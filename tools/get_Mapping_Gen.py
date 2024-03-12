import re
from numpy import nan
import pandas as pd
from c2json import getDict
import sys

module_name = sys.argv[2]
gen_path = '../build/gen/'+module_name+'_AppDiag_DTC_Mapping_Gen.h'

if len(sys.argv) < 5:
    sys.exit()
else:
    excel_path = sys.argv[4]

data = pd.read_excel(excel_path, sheet_name=None, header=None, engine='openpyxl')
json_dict = getDict()

#def_check_DTC():
#    check = 0
#    for i in list(data)[37:44]:
#       for j in data[i].index:
#            s = str(data[i]['DTC'][j])
#            if s[0] != "B" and s[0] != "U":
#                print(f'Error! DTC is [{s}] in Sheet < {i} > line {j+4}')
#                check = 1
#       if check == 1:
#           print('Please modify and continue')
#       return check

def ForreadDTC():
    df_dict = {}
    df1 = pd.read_excel(excel_path, sheet_name='DTC', header=0, engine='openpyxl')
    df1.fillna("",inplace=True)
    df_list = []
    df = df1.drop(['Index'],axis=1)
    for i in df.index.values:
        df_line = df.loc[i, ].to_dict()
        df_list.append(df_line)
        
        df dict['data'] df list
        return df dict
def readdtc():
    dat =  ForreadDTC()
    for key in dat:
        newlist = []
        for i in dat[key]:
            templist = []
            for v in i.values():
                if v == ':
                    continue        #break the current loop
                elif v[0]== 'U':    #U convert
                    a = f"(chr(ord('C') + int(v[l])) + v[2:]]"
                    templist.append(a)
                elif v[0] == 'B':   #B convert
                    a = f"9{v[2: ]]"
                    templist. append(a)
                elif v[0]== 'C':    #C convert
                    a = f"5{v[2: ]}"
                    templist.append(a)
                elif v. startswith('0x'):
                    templist.append(v[2:])
                else:       #break the current loop
                continue
            newlist.append(templist)
        return newlist
        
def get sheets dict():
    sheets_name_list = []          #提取excel中以Faul打头的表名，存成列表
    p = re. compile('Fault \d+.*')
    for i in list(data):
        r = re. match(p, i)
        if r:
            sheets_name_list.append(r.group())
    del_sheets_list = []
    sheets_list = []
    for i in sheets_name_list:     #在每张表第一列找到Event Number所在的那
        sheet =  data[i]
        new_header_index  = sheet[sheet[0].isin(['Event Number'])].index [0]
        new_header = list(sheet.loc[new_header_index])
        if 'DTC' in new_header:
            DTC_ColumnName ='DTC'
        elif module_name +''+'DTC' in new_header:
            DTC_ColumnName =  module_name +' ' + 'DTC'
        else:
            DTC_ColumnName = ''
            del_sheets_list.append(i)   #如果header里没有DTC一列，存到删除列表
            
        if DTC_ColumnName:
            sheet = sheet[new_header_index + 1:]
            sheet.columns = new_header
            sheet = sheet.reset_index(drop=True)
            DTC1 = []   #将转换后的DTC保存成新的一列
        for i in range(0, len (sheet [DTC_ColumnName])):
            j= sheet [DTC_ColumnName] [i]
            if j != j:
                sheet = sheet.drop(i)
            elif j[0]== 'U':    #U转换
                a = f"{chr(ord('C') + int(j[l])) + j[2:]}"
