import argparse
import requests
from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
from pdfminer.converter import TextConverter
from pdfminer.layout import LAParams
from pdfminer.pdfpage import PDFPage
from io import StringIO
import re
import os

def is_float(n):
    try:
        float(n)
    except ValueError:
        return False
    else:
        return True

def get_text_from_pdf(pdfname, limit=1000):
    # PDFファイル名が未指定の場合は、空文字列を返して終了
    if (pdfname == ''):
        return ''
    else:
        #処理するPDFファイルを開く/開けなければ
        try:
            fp = open(pdfname, 'rb')
        except:
            return ''

    #PDFからテキストの抽出
    rsrcmgr = PDFResourceManager()
    out_fp = StringIO()
    la_params = LAParams()
    la_params.detect_vertical = True
    #device = TextConverter(rsrcmgr, out_fp, codec='utf-8', laparams=la_params)
    device = TextConverter(rsrcmgr, out_fp, laparams=la_params)
    interpreter = PDFPageInterpreter(rsrcmgr, device)
    for page in PDFPage.get_pages(fp, pagenos=None, maxpages=0, password=None, caching=True, check_extractable=True):
        interpreter.process_page(page)
    text = out_fp.getvalue()
    fp.close()
    device.close()
    out_fp.close()

    #改行で分割する
    lines = text.splitlines()

    outputs = []
    output = ""

    #除去するutf8文字
    replace_strs = [b'\x00']

    is_blank_line = False

    #分割した行でループ
    for line in lines:

        #byte文字列に変換
        line_utf8 = line.encode('utf-8')

        #余分な文字を除去する
        for replace_str in replace_strs:
            line_utf8 = line_utf8.replace(replace_str, b'')

        #strに戻す
        line = line_utf8.decode()

        #連続する空白を一つにする
        line = re.sub("[ ]+", " ", line)

        #前後の空白を除く
        line = line.strip()
        #print("aft:[" + line + "]")

        #空行は無視
        if len(line) == 0:
            is_blank_line = True
            continue

        #数字だけの行は無視
        if is_float(line):
            continue

        #1単語しかなく、末尾がピリオドで終わらないものは無視
        if line.split(" ").count == 1 and not line.endswith("."):
            continue

        #文章の切れ目の場合
        if is_blank_line or output.endswith("."):
            # 文字数がlimitを超えていたらここで一旦区切る
            if(len(output) > limit):
                outputs.append(output)
                output = ""
            else:
                output += "\r\n"
        #前の行からの続きの場合
        elif not is_blank_line and output.endswith("-"):
            output = output[:-1]
        #それ以外の場合は、単語の切れ目として半角空白を入れる
        else:
            output += " "

        #print("[" + str(line) + "]")
        output += str(line)
        is_blank_line = False

    outputs.append(output)
    return outputs

def main():

    #PDFの読み込み
    parser = argparse.ArgumentParser()
    parser.add_argument("-input", type=str, required=True)
    parser.add_argument("-limit", type=int, default=1000)
    args = parser.parse_args()

    #PDFと同じ場所に翻訳結果を出力するためパスを取得
    path = os.path.dirname(args.input)
    base_name = os.path.splitext(os.path.basename(args.input))[0]

    #PDFをテキストに変換
    inputs = get_text_from_pdf(args.input, limit=args.limit)

    #APIのキーを取得
    API_KEY = ******** //自分の登録キーを入れる

    with open(path + "Sample.txt", "w", encoding="utf-8") as f_text:

        for i,input in enumerate(inputs):

            #DeepLのAPI
            params = {
                "auth_key":API_KEY,
                "text":input,
                "source_lang":"EN",
                "target_lang":"JA"
            }

            request = requests.post("https://api-free.deepl.com/v2/translate", data=params)
            result = request.json()
            text = result["translations"][0]["text"]

            f_text.write(text)
            print("{0}/{1} is proccessing".format((i+1), len(inputs)))

if __name__ == "__main__":
    main()
