
{*****************************************}
{                                         }
{             FastReport v2.3             }
{           Resource constants            }
{                                         }
{  Copyright (c) 1998-99 by Tzyganenko A. }
{                                         }
{*****************************************}

unit lr_const_CN;

interface

{$I LR_vers.inc}


resourcestring
//--- ShapeForm resources
  sShapeFormCaption='形状';//'Shape';
  sShapeFormKind   ='形状种类';//'Shape kind';
  
//--- RoundRectForm resources -------------------------------------------------
sRoundRectFormCaption='属性编辑器';//'Property editor';
sRoundRectFormSample='例子:';//'Sample :';
sRoundRectFormVar='变量...';//'Variables ...';
sRoundRectFormData='数据...';//'Data ..';
sRoundRectFormGradient='渐变';//'Gradient';
sRoundRectFormShadow='阴影宽度';//'Shadow width';
sRoundRectFormColor='颜色';//'Color';
sRoundRectFormCurve='曲线';//'Curve';
sRoundRectFormFramed='框架区';//'Framed zone';
sRoundRectFormEndColor='结束颜色';//'End Color';
sRoundRectFormBeginColor='开始颜色';//'Begin color';
sRoundRectFormStyle='样式';//'Style';
sRoundRectFormStyleDif='垂直,水平,椭圆形,矩形,水平中间,垂直居中';//'Vertical,Horizontal,Elliptic,Rectangle,Horiz._Center,Vert._Center';
sRoundRectFormHint='单击此处定义阴影颜色或渐变颜色';//'Click here to define the shadow color or gradient colors';
sRoundRectSqrCorners='方角';//'Squared corners';

//--- PgoptForm resources -----------------------------------------------------
sPgoptFormCapt = '页面选项';//'Page options';
sPgoptFormPaper = '纸张';//'Paper';
sPgoptFormOr = '方向';//'Orientation';
sPgoptFormPort ='纵向';// '&Portrait';
sPgoptFormLand ='横向';// '&Landscape';
sPgoptFormSize = '尺寸';//'Size';
sPgoptFormWidth = '宽,mm';//'&Width, mm';
sPgoptFormHeight ='高,mm';// '&Height, mm';
sPgoptFormMargins = '边距';//'Margins';
sPgoptFormPgMargins = '页边距';//'Page margins';
sPgoptFormLeft = '左,mm';//'&Left, mm';
sPgoptFormTop = '顶,mm';//'&Top, mm';
sPgoptFormRight = '右,mm';//'&Right, mm';
sPgoptFormBottom = '底,mm';//'&Bottom, mm';
sPgoptFormDontUse = '不使用';//'&Don''t use';
sPgoptFormOptions = '选项';//'Options';
sPgoptFormpRINT = '打印到上一页';//'&Print to previous page';
sPgoptFormColumn ='列';// 'Columns';
sPgoptFormNumber = '数量';//'&Number';
sPgoptFormColGap = '列间隔';//'&Column gap, mm';
sPgoptFormLayoutOrder = '布局顺序';//'Layout Order';
sPgoptFormByColumns = '按列';//'By Colum&ns';
sPgoptFormByRows = '按行';//'By Row&s';
sPgoptFormInvalidCustomPaperSize ='自定义纸张大小无效.';// 'Invalid custom paper size.';

//--- EditorForm resources ----------------------------------------------------
sEditorFormCapt = '文本编辑器';//'Text editor';
sEditorFormMemo = '&Memo';
sEditorFormScript ='脚本';// '&Script';
sEditorFormBig = '大字体';//'&Big font';
sEditorFormWord ='换行';// '&Word wrap';
sEditorFormScr = '脚本';//'S&cript';
sEditorFormVar = '变量';//'&Variable';
sEditorFormField = '数据库字段';//'&DB field';
sEditorFormFormat = '格式';//'&Format';
sEditorFormFunction = '函数';//'Function';

//--- DesOptionsForm resources ------------------------------------------------
sDesOptionsFormOpt ='选项';// 'Options';
sDesOptionsFormDes = '设计';//'Designer';
sDesOptionsFormGrid = '网格';//'Grid';
sDesOptionsFormObj ='对象移动';// 'Object moving';
sDesOptionsFormUnits = '报表单元';//'Report units';
sDesOptionsFormGrdSize = '网格尺寸';//'Grid size';
sDesOptionsFormShowGrd = '显示网格';//'&Show grid';
sDesOptionsFormAlignGrd = '与网格对齐';//'Align to &grid';
sDesOptionsFormColoredButton = '颜色按钮';//'Colored &buttons';
sDesOptionsForm4Pix ='4个像素';// '&4 pixels';
sDesOptionsForm8Pix ='8个像素';// '&8 pixels';
sDesOptionsForm18pix ='18个像素(5mm)';// '&18 pixels (5mm)';
sDesOptionsFormShape = '形状';//'S&hape';
sDesOptionsFormContents ='内容';// '&Contents';
sDesOptionsFormPix ='像素';// '&Pixels';
  sDesOptionsFormmm = '&MM';
  sDesOptionsFormInch ='英寸';// '&Inches';
  sDesOptionsFormOther = '其他';//'Other';
  sDesOptionsFormEditing = '插入后编辑';//'&Editing after insert';
  sDesOptionsFormShowBand ='显示band和标题';// 'Show band &titles';
  sDesOptionsFormInPlace = '使用原地编辑';//'Use inplace editor';

//--- HilightForm resources ---------------------------------------------------
sHilightFormHilitAttr ='突出显示属性';// 'Highlight attributes';
sHilightFormCond ='条件';// 'Condition';
sHilightFormFont = '字体';//'Font';
sHilightFormColor ='颜色';// 'C&olor ...';
sHilightFormBold = '粗体';//'&Bold';
sHilightFormItalic = '斜体';//'&Italic';
sHilightFormUnder = '下划线';//'&Underline';
sHilightFormBack = '底色';//'Background';
sHilightFormColor2 = '颜色';//'Co&lor ...';
sHilightFormTransp = '透明';//'&Transparent';
sHilightFormOther = '其他';//'Ot&her';

//--- FieldsForm resources ----------------------------------------------------
sFieldsFormInsert ='插入数据库字段';// 'Insert DB field';
sFieldsFormAviableDB = '可用数据库';//'&Available DB''s';

//--- DocOptForm resources ----------------------------------------------------
sDocOptFormOpt        = '报表选项';//'Report options';
sDocOptFormPrinter    = '打印机';//'Printer';
sDocOptFormSelect     = '选择何时加载报表';//'&Select when report loaded';
sDocOptFormOther      = '其他';//'Other';
sDocOptForm2Pass      = '两遍报表';//'&Two-pass report';
sDocOptFormTitle      = '标题';//'Title';
sDocOptFormSubject    = '主题';//'Subject';
sDocOptFormKeyWords   = '关键字';//'Keywords';
sDocOptFormComments   = '注释';//'Comments';
sDocVersion           = '版本';//'Version';
sDocMajor             = '主要';//'Major';
sDocMinor             = '次要';//'Minor';
sDocRelease           = '发行';//'Release';
sDocBuild             = '创建';//'Build';
sDocAutor             = '作者';//'Author';
sReportCreateDate     = '报表创建日期';//'Report creation date';
sReportLastModifyDate = '报表最后修改日期';//'Report last modification date';

  
//--- EvForm resources --------------------------------------------------------
sEvFormCapt = '变量编辑器';//'Variables editor';
sEvFormVar = '变量';//'&Variable';
sEvFormValue = '值';//'Va&lue';
sEvFormExp = '表达';//'&Expression';
sEvFormCopy = '拷贝变量';//'Copy variables';
sEvFormPaste = '粘贴变量';//'Paste variables';
sEvFormVars = '变量...';//'Va&riables ...';

//--- VaredForm resources -----------------------------------------------------
sVaredFormCapt = '变量列表';//'Variables list';
sVaredFormCat = '类别和变量';//'&Categories and variables';

//--- TemplForm resources -----------------------------------------------------
sTemplFormNewRp = '新报表';//'New report';
sTemplFormDesc  = '描述';//'Description';
sNewTemplate    = '新模板';//'New template';
sTemplEmtpyRp   = '空模板';//'Empty template';
sTemplEmptyDesc = '基于空模板的新报表';//'New report based on empty template';

//--- GEditorForm resources ---------------------------------------------------
sGEditorFormCapt = '图片';//'Picture';
sGEditorFormStretch = '缩放';//'&Stretch';
sGEditorFormLoad = '装载...';//'&Load ...';
sGEditorFormClear = '清空';//'&Clear';
sGEditorFormMemo = '&Memo';

//--- VarForm resources -------------------------------------------------------
sVarFormCapt = '变量';//'Variables';
sVarFormCat = '类型';//'&Category:';

//--- Object names ------------------------------------------------------------
sBand1  = '报表标题';//'Report title';
sBand2  = '报表主题';//'Report summary';
sBand3  = '页头';//'Page header';
sBand4  = '页脚';//'Page footer';
sBand5  = '主项头';//'Master header';
sBand6  = '主项数据';//'Master data';
sBand7  = '主项脚';//'Master footer';
sBand8  = '明细头';//Detail header';
sBand9  = '明细数据';//'Detail data';
sBand10 = '明细脚';//'Detail footer';
sBand11 = '子明细头';//'Subdetail header';
sBand12 = '子明细数据';//'Subdetail data';
sBand13 = '子明细脚';//'Subdetail footer';
sBand14 = '覆盖';//'Overlay';
sBand15 = '列头';//'Column header';
sBand16 = '列脚';//'Column footer';
sBand17 = '组头';//'Group header';
sBand18 = '组脚';//'Group footer';
sBand19 = '交叉头';//'Cross header';
sBand20 = '交叉数据';//'Cross data';
sBand21 = '交叉脚';//'Cross footer';
sBand22 = '';//'Child';
sBand23 = 'None';

sVar1 = '页#';//'Page#';
sVar2 = '表达式';//'Expression';
sInsert = '插入';//'Insert';
sDBField = '数据库字段';//'DB field';
sVariable = '变量';//'Variable';
sVar3 = '日期';//'Date';
sVar4 = '时间';//'Time';
sVar5 = '行#';//'Line#';
sVar6 = 'Line through#';
sVar7 = '列#';//'Column#';
sVar8 = '当前行#';//'Current line#';
sVar9 = '总页数';//'TotalPages';

//--- General resources -------------------------------------------------------
  sOk = '确定';
  sCancel = '取消';
  sPg = '页';
  sRepFile = '报表文件';//'Report file';
  sRemovePg = '删除这页？';//'Remove this page?';
  sConfirm = '确认';
  sStretched = '拉伸';
  sVarFormat = '变量格式...';//'Variable format ...';
  sFont = '字体...';//'Font ...';

  sWordWrap       = '换行';//'Word wrap';
  sWordBreak      = '断字';//'Word break';
  sAutoSize       = '自动大小';//'Auto size';
  sHideZeroValues = '隐藏零值';//'Hide zero values';
  sErrorOccurred = '计算过程中出错';//'An error occurred during calculation';

  sCharset  = '0';
  sNotAssigned = '[None]';
  sFormNewPage = '强制新页面';//'Force new page';
  sPrintIfSubsetEmpty = '明细空时也打印';//'Print if detail empty';
  sPrintChildIfNotVisible = '子对象不可见时也打印';//'Print child if not visible';
  sBreaked = '分割';//'Breaked';
  sPictureCenter = '图片居中';//'Center picture';
  sKeepAspectRatio = '保持纵横比';//'Keep aspect ratio';
  sKeepChild = 'Keep child together with parent';

  sFormFile        = 'FastReport报表';//'FastReport form';
  sTemplFile       = 'FastReport模板';//'FastReport template';
  sLazFormFile     = 'LazReport报表';//'LazReport form';
  sLazTemplateFile = 'LazReport模板';//'LazReport template';

  sPictFile = 'Picture file';
  sBMPFile = 'Bitmap file';
  sAllFiles = 'All files';
  sInsCheckBox = '插入CheckBox';//'Insert CheckBox object';
  sInsChart = '插入图表';//'Insert Chart object';
  sInsShape = '插入形状';//'Insert Shape object';
  sInsBarcode = '插入条形码';//'Insert Barcode object';
  sInsRoundRect = '插入带有阴影区域的RoundRect';//'Insert a RoundRect with shadow area';
  sInsCrossTab = '插入交叉表';//'Insert Cross-tab object';
  sSubReportOnPage = 'SubReport on page';
  sPicture = '[图片]';//'[Picture]';
  sTransparent = '透明';//'Transparent';
  sOther = '其他...';//'Other ...';
  sOnFirstPage = '在第一页';//'On first page';
  sOnLastPage = '在最后一页';//'On last page';
  sRepeatHeader = '显示全部页';//'Show on all pages';
  sDesignReport = '设计报表';//'Design report';
  sInsertFields = '插入数据库字段';//'Insert DB fields';
  sSaveChanges = '保存更改';//'Save changes';
  sTo = 'to';
  sShape1 = '矩形';//'Rectangle';
  sShape2 = '圆角矩形';//'Rounded rectangle';
  sShape3 = '椭圆';//'Ellipse';
  sShape4 = '三角形';//'Triangle';
  sShape5 = '对角线1';//'Diagonal1';
  sShape6 = '对角线2';//'Diagonal2';
  sPixels = '像素';//'Pixels';
  sMM = 'MM';
  sInches = '英寸';//'Inches';
  sVirtualDataset = '虚拟数据集';//'Virtual Dataset';
  sFRVariables = 'FR变量';//'FR variables';
  sErrorOccured = '计算过程中出错';//'An error occurred during calculation';
  sSpecVal = '其他';//'Other';
  sInvalidFRFReport = '无效的二进制报表';//'Invalid binary report';
  sInvalidLRFReport = '无效的报告格式';//'Invalid report format';
  sUnableToReadVersion = '无法读取报表版本';//'Unable to read report version';
  sInvalidFRFVersion = '报表版本无效';//'Invalid report version';
  sReportLoadingError = '加载报表时出错';//'Error while loading report';
  sClassObjectNotFound = '找不到类对象“%s”';//'Class Object "%s" not found';
  sDuplicatedObjectName ='名为“%s”的对象已存在';// 'An object named "%s" already exists';
  sObjectNotFound = '找不到"%s" 对象';//'Object "%s" not found';
  sFileNotFound = '文件没找到';//'File not found';
  sNoValidFilterClassWasSupplied    = '未提供有效的筛选器类';//'No valid filterclass was supplied';
  sNoValidExportFilenameWasSupplied = '没有提供有效的导出文件名';//'No valid export filename was supplied';

  SDoc       = 'Report:';
  SBand      = 'Band:';
  sCurMemo   = 'Memo:';
  SReportPreparing = '准备报告';//'Preparing report';
  SFirstPass = '执行第1次:';//'Performing 1st pass:';
  SPagePreparing = '处理页面:';//'Processing page:';
  SError = '错误';//'Error';
  SPreview = '预览';//'Preview';
  SPagePrinting = '打印页:';//'Printing page:';
  SUntitled = '无标题';//'Untitled';
  SPrinterError = '所选打印机无效';//'Selected printer is not valid';
  STextFile = 'ASCII Text文件';//'ASCII Text file';
  SRTFFile = 'Rich Text文件';//'Rich Text file';
  SCSVFile = 'CSV文件';//'CSV File';
  SHTMFile = 'HTML文件';//'HTML file';
  SFilter = '过滤器属性';//'Filter properties';
  SFilterParam = '平均字体高度:';//'Average font height:';
  sFrom = 'from';
  sDefaultPrinter = '默认打印机';//'Default printer';
  sExportFilterIndexError = '导出筛选器索引超出范围';//'Export filter index out of range';
  sFindTextNotFound = '未找到搜索文本.';//'Search text not found.';
  sInvalidVariableName = '"%s"不是有效的变量名.';//'"%s" is not a valid variable name.';

//--- PrintForm resources ---------------------------------------------------
  sPrintFormPrint = '打印';//'Print';
  sPrintFormPrinter = '打印机';//'Printer';
  sPrintFormProp = '属性';//'Properties';
  sPrintFormCopy = '打印份数:';//'&Copies:';
  sPrintFormPgRange = '打印页范围';//'Page range';
  sPrintFormAll = '全部';//'&All';
  sPrintFormCurPg = '当前页';//'Current &page';
  sPrintFormNumber= '页码:';//'&Numbers:';
  sPrintFormInfo = '输入页码或页码范围，用逗号分隔。例如:1,3,5-12';//'Enter page numbers and/or page ranges, separated by commas. For example, 1,3,5-12';
  sPrintFormCollate = '逐份打印';//'Collate';

//--- BandEditorForm resources ------------------------------------------------
  sBandEditorFormCapt = 'Band数据源';//'Band data source';
  sBandEditorFormDataSrc = '数据源';//'Data source';
  sBandEditorFormRecCount = '记录数';//'&Record count';

//--- BandTypesForm resources -------------------------------------------------
  sBandTypesFormCapt = '插入新Band';//'Insert new band';
  sBandTypesFormBType ='Band类型';//'Band type';

//--- GroupEditorForm resources -----------------------------------------------
  sGroupEditorFormCapt = '组';//'Group';
  sGroupEditorFormCond = '条件';//'Condition';
  sGroupEditorFormAddDbField = '插入数据库字段';//'Insert DB field';

//--- InsertFieldsForm resources ----------------------------------------------
  sInsertFieldsFormCapt = '插入字段';//'Insert fields';
  sInsertFieldsFormAviableDSet = '可用数据集';//'&Available datasets';
  sInsertFieldsFormPlace = '布局';//'Placement';
  sInsertFieldsFormHorz = '水平';//'&Horizontal';
  sInsertFieldsFormVert = '垂直';//'&Vertical';
  sInsertFieldsFormHeader = '包含标题';//'&Include headers';
  sInsertFieldsFormBand = '包含bands';//'Include &bands';
  sInsertFieldsDbNoFields = '不带字段的数据库';//'Database without fields';

//--- AboutForm resources -----------------------------------------------------
  sAboutFormCapt = 'About LazReport';

//---- Paper Src --------------------------------------------------------------
  sPaper1 = 'Letter, 8 1/2 x 11"';
  sPaper2 = 'Letter small, 8 1/2 x 11"';
  sPaper3 = 'Tabloid, 11 x 17"';
  sPaper4 = 'Ledger, 17 x 11"';
  sPaper5 = 'Legal, 8 1/2 x 14"';
  sPaper6 = 'Statement, 5 1/2 x 8 1/2"';
  sPaper7 = 'Executive, 7 1/4 x 10 1/2"';
  sPaper8 = 'A3 297 x 420 mm';
  sPaper9 = 'A4 210 x 297 mm';
  sPaper10 = 'A4 small sheet, 210 x 297 mm';
  sPaper11 = 'A5 148 x 210 mm';
  sPaper12 = 'B4 250 x 354 mm';
  sPaper13 = 'B5 182 x 257 mm';
  sPaper14 = 'Folio, 8 1/2 x 13"';
  sPaper15 = 'Quarto Sheet, 215 x 275 mm';
  sPaper16 = '10 x 14"';
  sPaper17 = '11 x 17"';
  sPaper18 = 'Note, 8 1/2 x 11"';
  sPaper19 = '9 Envelope, 3 7/8 x 8 7/8"';
  sPaper20 = '#10 Envelope, 4 1/8  x 9 1/2"';
  sPaper21 = '#11 Envelope, 4 1/2 x 10 3/8"';
  sPaper22 = '#12 Envelope, 4 3/4 x 11"';
  sPaper23 = '#14 Envelope, 5 x 11 1/2"';
  sPaper24 = 'C Sheet, 17 x 22"';
  sPaper25 = 'D Sheet, 22 x 34"';
  sPaper26 = 'E Sheet, 34 x 44"';
  sPaper27 = 'DL Envelope, 110 x 220 mm';
  sPaper28 = 'C5 Envelope, 162 x 229 mm';
  sPaper29 = 'C3 Envelope,  324 x 458 mm';
  sPaper30 = 'C4 Envelope,  229 x 324 mm';
  sPaper31 = 'C6 Envelope,  114 x 162 mm';
  sPaper32 = 'C65 Envelope, 114 x 229 mm';
  sPaper33 = 'B4 Envelope,  250 x 353 mm';
  sPaper34 = 'B5 Envelope,  176 x 250 mm';
  sPaper35 = 'B6 Envelope,  176 x 125 mm';
  sPaper36 = 'Italy Envelope, 110 x 230 mm';
  sPaper37 = 'Monarch Envelope, 3 7/8 x 7 1/2"';
  sPaper38 = '6 3/4 Envelope, 3 5/8 x 6 1/2"';
  sPaper39 = 'US Std Fanfold, 14 7/8 x 11"';
  sPaper40 = 'German Std Fanfold, 8 1/2 x 12"';
  sPaper41 = 'German Legal Fanfold, 8 1/2 x 13"';
  sPaper42 = 'B4 (ISO) 250 x 353 mm';
  sPaper43 = 'Japanese Postcard 100 x 148 mm';
  sPaper44 = '9 x 11"';
  sPaper45 = '10 x 11"';
  sPaper46 = '15 x 11"';
  sPaper47 = 'Envelope Invite 220 x 220 mm';
  sPaper50 = 'Letter Extra 9/275 x 12"';
  sPaper51 = 'Legal Extra 9/275 x 15"';
  sPaper52 = 'Tabloid Extra 11.69 x 18"';
  sPaper53 = 'A4 Extra 9.27 x 12.69"';
  sPaper54 = 'Letter Transverse 8/275 x 11"';
  sPaper55 = 'A4 Transverse 210 x 297 mm';
  sPaper56 = 'Letter Extra Transverse 9/275 x 12"';
  sPaper57 = 'SuperASuperAA4 227 x 356 mm';
  sPaper58 = 'SuperBSuperBA3 305 x 487 mm';
  sPaper59 = 'Letter Plus 8.5 x 12.69"';
  sPaper60 = 'A4 Plus 210 x 330 mm';
  sPaper61 = 'A5 Transverse 148 x 210 mm';
  sPaper62 = 'B5 (JIS) Transverse 182 x 257 mm';
  sPaper63 = 'A3 Extra 322 x 445 mm';
  sPaper64 = 'A5 Extra 174 x 235 mm';
  sPaper65 = 'B5 (ISO) Extra 201 x 276 mm';
  sPaper66 = 'A2 420 x 594 mm';
  sPaper67 = 'A3 Transverse 297 x 420 mm';
  sPaper68 = 'A3 Extra Transverse 322 x 445 mm';
  // new papers
  sPaper69 = 'Double Japanese Postcard 200 x 148 mm';
  sPaper70 = 'A6 105x148 mm';
  sPaper71 = 'DMPAPER_JENV_KAKU2 240X132';
  sPaper72 = 'DMPAPER_JENV_KAKU3 216X277';
  sPaper73 = 'DMPAPER_JENV_CHOU3 120X235';
  sPaper74 = 'DMPAPER_JENV_CHOU4 90X205';
  sPaper75 = 'DMPAPER_LETTER_ROTATED 279.4x215.9';
  sPaper76 = 'DMPAPER_A3_ROTATED 420x297';
  sPaper77 = 'DMPAPER_A4_ROTATED 297X210';
  sPaper78 = 'DMPAPER_A5_ROTATED 210X148';
  sPaper79 = 'DMPAPER_B4_JIS_ROTATED 364X257';
  sPaper80 = 'DMPAPER_B5_JIS_ROTATED 257X182';
  sPaper81 = 'DMPAPER_JAPANESE_POSTCARD_ROTATED 148X100';
  sPaper82 = 'DMPAPER_DBL_JAPANESE_POSTCARD_ROTATED 148X200';
  sPaper83 = 'DMPAPER_A6_ROTATED 148X105';
  sPaper84 = 'DMPAPER_JENV_KAKU2_ROTATED 332X240';
  sPaper85 = 'DMPAPER_JENV_KAKU3_ROTATED 277X216';
  sPaper86 = 'DMPAPER_JENV_CHOU3_ROTATED 235X120';
  sPaper87 = 'DMPAPER_JENV_CHOU4_ROTATED 205X90';
  sPaper88 = 'DMPAPER_B6_JIS 128X122';
  sPaper89 = 'DMPAPER_B6_JIS_ROTATED 182X128';
  sPaper90 = 'DMPAPER_12X11 304.8X279.4';
  sPaper91 = 'DMPAPER_JENV_YOU4 105X235';
  sPaper92 = 'DMPAPER_JENV_YOU4_ROTATED 235X105';
  sPaper93 = 'DMPAPER_P16K 146X215';
  sPaper94 = 'DMPAPER_P32K 97X151';
  sPaper95 = 'DMPAPER_P32KBIG 97X151';
  sPaper96 = 'DMPAPER_PENV_1 102X165';
  sPaper97 = 'DMPAPER_PENV_2 102X176';
  sPaper98 = 'DMPAPER_PENV_3 125X176';
  sPaper99 = 'DMPAPER_PENV_4 110X208';
  sPaper100= 'DMPAPER_PENV_5 110X220';
  sPaper101= 'DMPAPER_PENV_6 120X230';
  sPaper102= 'DMPAPER_PENV_7 160X230';
  sPaper103= 'DMPAPER_PENV_8 120X309';
  sPaper104= 'DMPAPER_PENV_9 229X324';
  sPaper105= 'DMPAPER_PENV_10 324X458';
  sPaper106= 'DMPAPER_P16K_ROTATED 215X146';
  sPaper107= 'DMPAPER_P32K_ROTATED 151X97';
  sPaper108= 'DMPAPER_P32KBIG_ROTATED 151X97';
  sPaper109= 'DMPAPER_PENV_1_ROTATED 165X102';
  sPaper110= 'DMPAPER_PENV_2_ROTATED 176X102';
  sPaper111= 'DMPAPER_PENV_3_ROTATED 176X125';
  sPaper112= 'DMPAPER_PENV_4_ROTATED 208X110';
  sPaper113= 'DMPAPER_PENV_5_ROTATED 220X110';
  sPaper114= 'DMPAPER_PENV_6_ROTATED 230X120';
  sPaper115= 'DMPAPER_PENV_7_ROTATED 230X160';
  sPaper116= 'DMPAPER_PENV_8_ROTATED 309X120';
  sPaper117= 'DMPAPER_PENV_9_ROTATED 324X229';
  sPaper118= 'DMPAPER_PENV_10_ROTATED 458X324';
  sPaper256 = '自定纸张';//'Custom';

//--- FRDesignerForm resources ------------------------------------------------
  sFRDesignerFormCapt = '设计';//'Designer';
  sFRDesignerFormrect = '矩形';//'Rectangle';
  sFRDesignerFormStd = '标准';//'Standard';
  sFRDesignerFormText = '文本';//'Text';
  sFRDesignerFormObj = '对象';//'Objects';
  sFRDesignerFormAlign = '对齐';//'Alignment';
  sFRDesignerFormTools = '工具';//'Tools';
  sFRDesignerFormNewRp = '新报表';//'New report';
  sFRDesignerFormOpenRp = '打开报表';//'Open report';
  sFRDesignerFormSaveRp = '保存报表';//'Save report';
  sFRDesignerFormPreview = '预览报表';//'Preview report';
  sFRDesignerFormCut = '剪切';//'Cut';
  sFRDesignerFormCopy = '拷贝';//'Copy';
  sFRDesignerFormPast = '粘贴';//'Paste';
  sFRDesignerFormUndo = '撤消最后一个操作';//'Undo last action';
  sFRDesignerFormRedo = '重做已取消的操作';//'Redo cancelled action';
  sFRDesignerFormBring = '置于前面';//'Bring to front';
  sFRDesignerFormBack = '置于底层';//'Send to back';
  sFRDesignerFormSelectAll = '全选';//'Select all';
  sFRDesignerFormAddPg = '添加页面';//'Add page';
  sFRDesignerFormRemovePg = '删除页面';//'Remove page';
  sFRDesignerFormPgOption = '页面选项';//'Page options';
  sFRDesignerFormGrid = '网格';//'Grid';
  sFRDesignerFormGridAlign = '网格对齐';//'Grid align';
  sFRDesignerFormFitGrid = '适应网络';//'Fit to grid';
  sFRDesignerFormGuides ='显示辅助线';//LBZ 2022.06.17 增加
  SVerticalequaldistributiontable='垂直匀分单元格';//LBZ
  ShorizontalEqualdistributiontable='水平匀分单元格';//lbz
  SSplitCell='拆分单元格';//LBZ
  SMergecell='合并单元格';//LBZ
  sFRDesignerFormClose = '关闭';//'Close';
  sFRDesignerFormCloseDesigner = '关闭设计';//'Close designer';
  sFRDesignerFormLeftAlign = '左对齐';//'Left align';
  sFRDesignerFormRightAlign = '右对齐';//'Right align';
  sFRDesignerFormCenerAlign = '居中对齐';//'Center align';
  sFRDesignerFormNormalText = '正常文本/90度';//'Normal text / 90 degrees';
  sFRDesignerFormVertCenter = '垂直中心';//'Vertical center';
  sFRDesignerFormTopAlign = '顶对齐';//'Top align';
  sFRDesignerFormBottomAlign = '底对齐';//'Bottom align';
  sFRDesignerFormWidthAlign = '宽度对齐';//'Width align';
  sFRDesignerFormBold = '加粗';//'Bold';
  sFRDesignerFormItalic = '斜体';//'Italic';
  sFRDesignerFormUnderLine = '下划线';//'Underline';
  sFRDesignerFormFont = '字体颜色';//'Font color';
  sFRDesignerFormHightLight = '突出显示属性';//'Highlight attributes';
  sFRDesignerFormFontSize = '字体大小';//'Font size';
  sFRDesignerFormFontName = '字体名称';//'Font name';
  sFRDesignerFormTopFrame = '顶边框线';//'Top frame line';
  sFRDesignerFormleftFrame = '左边框线';//'Left frame line';
  sFRDesignerFormBottomFrame = '底边框线';//'Bottom frame line';
  sFRDesignerFormRightFrame = '右顶边框线';//'Right frame line';
  sFRDesignerFormAllFrame = '所有边框线';//'All frame lines';
  sFRDesignerFormNoFrame = '没边框线';//'No frame';
  sFRDesignerFormBackColor = '底色';//'Background color';
  sFRDesignerFormFrameColor = '边框颜色';//'Frame color';
  sFRDesignerFormFrameWidth = '边框宽度';//'Frame width';
  sFRDesignerFormSelectSameClass = '选择相同的类对象';//'Select same class objects';
  sFRDesignerFormCellsplitting='单元格拆分';
  sFRDesignerFormNumberofrows='行数';
  sFRDesignerFormNumberofcols='列数';
  sFRDesignerFormVerticaluniformdistribution = '多行各列单元格需对齐后才能垂直匀分。';
  sFRDesignerFormHorizontaluniformdistribution = '多行各列单元格需对齐后才能水平匀分。';
  sLRSpreadSheetImportForm='使用非标准对象名称（提高导入速度）';//'Use not standart object names (improve import speed)';
  //  53131 = 'Frame width';
  sFRDesignerFormSelObj ='选择对象';// 'Select object';
  sFRDesignerFormInsRect = '插入矩形';//'Insert rectangle object';
  sFRDesignerFormInsBand = '插入band';//'Insert band';
  sFRDesignerFormInsPict = '插入图片';//'Insert picture';
  sFRDesignerFormInsSub = '插入子报表';//'Insert subreport';
  sFRDesignerFormDrawLine = '画线条';//'Draw lines';
  sFRDesignerFormAlignLeftedge = '对齐左边缘';//'Align left edges';
  sFRDesignerFormAlignHorzCenter = '水平居中';//'Align horizontal centers';
  sFRDesignerFormCenterHWind = '在窗口中水平居中';//'Center horizontally in window';
  sFRDesignerFormSpace = '水平均分';//'Space equally, horizontally';
  sFRDesignerFormAlignRightEdge = '对齐右边缘';//'Align right edges';
  sFRDesignerFormAligneTop = '顶部对齐';//'Align tops';
  sFRDesignerFormAlignVertCenter = '垂直居中';//'Align vertical centers';
  sFRDesignerFormCenterVertWing = '在窗口中垂直居中';//'Center vertically in window';
  sFRDesignerFormSpaceEqVert = '垂直均分';//'Space equally, vertically';
  sFRDesignerFormAlignBottoms = '底部对齐';//'Align bottoms';
  sFRDesignerForm_Cut = '剪切';//'C&ut';
  sFRDesignerForm_Copy = '拷贝';//'&Copy';
  sFRDesignerForm_Paste = '粘贴';//'&Paste';
  sFRDesignerForm_Delete = '删除';//'&Delete';
  sFRDesignerForm_SelectAll = '全选';//'Select &all';
  sFRDesignerForm_Edit = '编辑...';//'&Edit ...';
  sFRDesignerForm_File = '文件';//'&File';
  sFRDesignerForm_New = '新建...';//'&New ...';
  sFRDesignerForm_Open = '打开...';//'&Open ...';
  sFRDesignerForm_Save = '保存';//'&Save';
  sFRDesignerForm_Var = '变量和列表...';//'Variables &list ...';
  sFRDesignerForm_RptOpt = '报表选项...';//'&Report options ...';
  sFRDesignerForm_PgOpt = '页面选项...';//'&Page options ...';
  sFRDesignerForm_preview = '预览';//'Pre&view';
  sFRDesignerForm_Exit = '退出';//'E&xit';
  sFRDesignerForm_Edit2 = '编辑';//'&Edit';
  sFRDesignerForm_Undo = '撤销';//'&Undo';
  sFRDesignerForm_Redo = '重做';//'&Redo';
  //sFRDesignerForm_Cut = 'C&ut';
  //sFRDesignerForm_Copy = '&Copy';
  //sFRDesignerForm_Paste = '&Paste';
  //sFRDesignerForm_Delete = '&Delete';
  //sFRDesignerForm_SelectAll = '&Select all';
  sFRDesignerForm_Editp = '编辑';//'&Edit ...';
  sFRDesignerForm_AddPg = '添页面';//'&Add page';
  sFRDesignerForm_RemovePg = '删除页面';//'&Remove page';
  sFRDesignerForm_Bring = '放置前面';//'Bring to &front';
  sFRDesignerForm_Back = '放置后面';//'Send to &back';
  sFRDesignerForm_Tools = '工具';//'&Tools';
  sFRDesignerForm_ToolBars = '工具栏';//'&Toolbars';
  sFRDesignerForm_Tools2 = '工具';//'Too&ls';
  sFRDesignerForm_Opts = '选项';//'&Options ...';
  sFRDesignerForm_Rect = '矩形';//'&Rectangle';
  sFRDesignerForm_Std = '标准';//'&Standard';
  sFRDesignerForm_Text = '文本';//'&Text';
  sFRDesignerForm_Obj = '对象';//'&Objects';
  sFRDesignerForm_Insp = '对象查看器';//'Object &Inspector';
  sFRDesignerForm_AlignPalette = '对齐板';//'&Alignment palette';
  sFRDesignerForm_Tools3 = '工具';//'Too&ls';
  sFRDesignerForm_DataInsp = '数据查看器';//'&Data inspector';
  sFRDesignerForm_About = '关于...';//'&About ...';
  sFRDesignerForm_SaveAs = '另存为...';//'Save &as ...';
  sFRDesignerForm_BeforePrintScript = '打印前的脚本';//'&Before print script ...';
  sFRDesignerForm_Help1 = '帮助内容';//'&Help contents';
  sFRDesignerForm_Help2 = '帮助工具';//'Help &tool';
  sFRDesignerForm_Line = '线条风格';//'Line style';
  sFRDesignerForm_Modified = '修改';//'Modified';
  sFRDesignerExists        = '您已经有一个TfrDesigner组件';//'You already have one TfrDesigner component';
  sFRDesignerDataInsp      = '数据查看器';//'Data inspector';
  sFrDesignerFormUnableToCreateTemplateDir = '无法创建模板目录';//'Unable to create template directory';

//--- InspForm resources ------------------------------------------------------
  sObjectInspector ='对象查看器';//'Object inspector';

//--- VBandEditorForm resources ------------------------------------------------
  sVBandEditorFormCapt ='Band数据源';// 'Band data sources';
  sVBandEditorFormBnd = 'Bands';
  sVBandEditorFormDataSource = '数据源';//'Data source';
  sVBandEditorFormRecordCount = '记录数量';//'&Record count';

//--- FmtForm resources -------------------------------------------------------
  sFmtFormFrmtVar = '变量格式';//'Variable formatting';
  sFmtFormVarFmt = '可变格式';//'Variable format';
  sFmtFormDeciD = '十进制数字';//'&Decimal digits';
  sFmtFormFrac = '分数与符号';//'Fraction &symbol';
  sFmtFormFrmt = '格式';//'&Format';

  sCateg1 = '文本';//'Text';
  sCateg2 = '数字';//'Number';
  sCateg3 = '日期';//'Date';
  sCateg4 = '时间';//'Time';
  sCateg5 = '布尔值';//'Boolean';

  sFormat11 ='[None]';

  sFormat21 ='1234,5';
  sFormat22 ='1234,50';
  sFormat23 ='1 234,5';
  sFormat24 ='1 234,50';
  sFormat25 ='定制';//'Custom';

  sFormat31 = '11.15.98';
  sFormat32 = '11.15.1998';
  sFormat33 = '15 nov 1998';
  sFormat34 = '15 november 1998';
  sFormat35 = '定制';

  sFormat41 = '02:43:35';
  sFormat42 = '2:43:35';
  sFormat43 = '02:43';
  sFormat44 = '2:43';
  sFormat45 = '定制';
  
  sFormat51 = '0;1';
  sFormat52 = 'No;Yes';
  sFormat53 = '_;x';
  sFormat54 = 'False;True';
  sFormat55 = '定制';
{
  sDateFormat1 = 'mm.dd.yy';
  sDateFormat2 = 'mm.dd.yyyy';
  sDateFormat3 = 'd mmm yyyy';
  sDateFormat4 = 'd mmmm yyyy';

  sTimeFormat1 = 'hh:nn:ss';
  sTimeFormat2 = 'h:nn:ss';
  sTimeFormat3 = 'hh:nn';
  sTimeFormat4 = 'h:nn';
}
//--- PreviewSearchForm resources ---------------------------------------------
  sFindTextCaption='查找文本';//'Find text';
  sFindTextText='文本查找';//'Text to &find';
  sFindTextOptions='选项';//'Options';
  sFindTextCase='区分大小写';//'&Case sensitive';
  sFindTextOrg='起点';//'Origin';
  sFindTextFirstPg='第一页';//'&1st page';
  sFindTextCurrentPg='当前页';//'Current &page';

//--- PreviewForm resources ---------------------------------------------------
  sPreviewFormPW='页面宽度';//'&Page width';
  sPreviewFormWhole='整页';//'&Whole page';
  sPreviewForm2Pg='两页';//'&Two pages';
  sPreviewFormClose='关闭预览';//'Close preview';
  sPreviewFormScale='比例';//'Scale';
  sPreviewFormOpen='打开报表';//'Open report';
  sPreviewFormSave='保存报表';//'Save report';
  sPreviewFormPrint='打印报表';//'Print report';
  sPreviewFormFind='查找文本';//'Find text';
  sPreviewFormEdit='编辑页面';//'Edit page';
  sPreviewFormAdd='添加 页面';//'Add page';
  sPreviewFormDel='删除页面';//'Delete page';
  sPreviewFormHelp='显示帮助';//'Show help';

//--- BarCodeForm resources ---------------------------------------------------
  sBarCodeFormTitle='条形码编辑器';//'Barcode editor';
  sBarCodeFormCode='编码';//'&Code';
  sBarCodeFormType='条形码类型';//'&Type of barcode';
  sBarCodeFormOpts='选项';//'Options';
  sBarCodeFormChksum='校验和';//'Check&sum';
  sBarCodeFormReadable='可读的';//'&Human readable';
  sBarCodeFormDbFld='插入数据库字段';//'Insert DB field';
  sBarCodeFormVar='插入变量';//'Insert variable';
  sBarCodeFormRotate='旋转';//'Rotation';
  SBarcodeError = '条形码错误';//'Error in barcode';
  sBarcodeZoom  = '放大(变焦)';//'Zoom';

//--- Descriptions ------------------------------------------------------------
  SAggregateCategory = '合计';//'Aggregate';
  SDateTimeCategory  = '日期和时间';//'Date and time';
  SStringCategory    = '字符串';//'String';
  SOtherCategory     = '其他';//'Other';
  SMathCategory      = '数学';//'Math';
  SInterpretator     = '解释';//'Interpretator';

  SDescriptionAVG = 'AVG(<Expression> [,BandName [,1]])/' +
    'Calculates the average of <Expression> for [BandName] row given. '+
    'If [1] parameter is used, calculates average for non-visible rows too.';

  SDescriptionCOUNT = 'COUNT(<BandName>)/'+
    'Returns count of data rows given in the <BandName>. ';

  SDescriptionDAYOF =  'DAYOF(<Date>)/'+
    'Returns day number (1..31) of given <Date>.';

  SDescriptionFORMATDATETIME = 'FORMATDATETIME(<Fmt>, <DateTime>)/'+
    'Converts a <DateTime> value to a string using mask in <Fmt>.';

  SDescriptionFORMATFLOAT = 'FORMATFLOAT(<Fmt>, <Numeric>)/'+
    'Converts a <Numeric> value to a string using mask in <Fmt>.';

  SDescriptionFORMATTEXT = 'FORMATTEXT(<Mask>, <String>)/'+
    'Applies <Mask> to given <String> and returns formatted string.';

  SDescriptionINPUT = 'INPUT(<Caption> [,Default])/'+
    'Shows dialog window with title <Caption> and edit box. '+
    'If [Default] parameter is set, puts this string in edit box. '+
    'After user clicks OK, returns input string.';

  SDescriptionLENGTH = 'LENGTH(<String>)/'+
    '返回 <String>长度';//'Returns length of <String>.';

  SDescriptionLOWERCASE =  'LOWERCASE(<String>)/'+
    '将<String>符号转换为小写.';//'Converts <String> symbols to lower case.';

  SDescriptionMAX = 'MAX(<Expression> [,BandName [,1]])/'+
    '计算给定[BandName]行的<Expression>最大值'+//'Calculates the maximum of <Expression> for [BandName] row given. '+
    '如果使用[1]参数，也会计算不可见行的最大值。';//'If [1] parameter is used, calculates maximum for non-visible rows too.';

  SDescriptionMIN = 'MIN(<Expression> [,BandName [,1]])/'+
    'Calculates the minimum of <Expression> for [BandName] row given. '+
    'If [1] parameter is used, calculates minimum for non-visible rows too.';

  SDescriptionMONTHOF = 'MONTHOF(<Date>)/'+
    '返回给定<日期>的月数(1..12).';//'Returns month number (1..12) of given <Date>.';

  SDescriptionNAMECASE = 'NAMECASE(<String>)/'+
    '将<String>符号转换为小写和第一个符号'+//'Converts <String> symbols to lower case, and first symbol '+
    '是大写的.';//'is in upper case.';

  SDescriptionSTRTODATE = 'STRTODATE(<String>)/'+
    '将<String>转换为日期.';//'Converts <String> to date.';

  SDescriptionSTRTOTIME = 'STRTOTIME(<String>)/' +
    '将<String>转换为时间.';//'Converts <String> to time.';

  SDescriptionSUM = 'SUM(<Expression> [,BandName [,1]])/'+
    'Calculates the sum of <Expression> for [BandName] row given. '+
    'If [1] parameter is used, calculates sum for non-visible rows too.';

  SDescriptionTRIM = 'TRIM(<String>)/'+
    'Trims all heading and trailing spaces in <String> and returns '+
    'resulting string.';

  SDescriptionUPPERCASE = 'UPPERCASE(<String>)/'+
    'Converts <String> symbols to upper case.';

  SDescriptionYEAROF = 'YEAROF(<Date>)/'+
    '返回指定<日期>的年份';//'Returns year of given <Date>.';

  SDescriptionMAXNUM = 'MAXNUM(<Value1>, <Value2>)/'+
    '返回指定变量的最大值.';//'Returns max of given values.';

  SDescriptionMINNUM = 'MINNUM(<Value1>, <Value2>)/'+
    '返回指定变量的最小值.';//'Returns min of given values.';

  SDescriptionPOS = 'POS(<SubString>, <String>)/'+
    '返回子字符串在指定字符串中的位置';//'Returns position of substring in given string.';

  SDescriptionMESSAGEBOX = 'MESSAGEBOX(<Text>, <Title>, <Buttons>)/'+
    '显示带有标题、文本和按钮的标准对话框窗口.';//'Shows standard dialog window with title, text and buttons.';

  SDescriptionCOPY = 'COPY(<String>, <Position>, <Length>)/'+
    'Returns <Length> characters from <String> starting at <Position>.';

  SDescriptionSTR = 'STR(<Value>)/'+
    'Converts the given (numeric) <Value> in string.';

  SDescriptionINT = 'INT(<Value>)/'+
    'Returns the integer part of floating point <Value>.';

  SDescriptionROUND = 'ROUND(<Value>)/'+
    'Rounds the floating point <Value> to nearest integer number.';

  SDescriptionFRAC = 'FRAC(<Value>)/'+
    'Returns the fractional part of floating point <Value>.';

  SDescriptionNEWPAGE = 'NEWPAGE/'+
    '为当前报表创建新页面。';//'Create new page for current report.';
  SDescriptionNEWCOLUMN =  'NEWCOLUMN/'+
    '在当前报表页面上为创建新列.';//'Create new column on page for current report.';

  SDescriptionSTOPREPORT = 'STOPREPORT/'+
    '终止报表创建';//'Terminate report creation.';

  SDescriptionSHOWBAND = 'SHOWBAND(<BandName>)/'+
    'Show <BandName> in report.';

  SDescriptionINC = 'INC(<Value>)/'+
    'Increment <Value>.';

  SDescriptionDEC = 'DEC(<Value>)/'+
    'Decrement <Value>.';

  SDescriptionIF = 'IF(<expression>, <Value1>, <Value2>)/' +
  'Returns <Value1>, if <expression> is true; otherwise returns <Value2>.';

 //Date and time display format
  sDateFormat1 = 'mm.dd.yy';
  sDateFormat2 = 'mm.dd.yyyy';
  sDateFormat3 = 'd mmm yyyy';
  sDateFormat4 = 'd mmmm yyyy';

  sTimeFormat1 = 'hh:nn:ss';
  sTimeFormat2 = 'h:nn:ss';
  sTimeFormat3 = 'hh:nn';
  sTimeFormat4 = 'h:nn';

  sInsertExpression = '插入表达式';//'Insert Expression';
  sFunctions = '函数';//'Functions';
  sArguments = '参数';//'Arguments';
  sFunctionEditor = '函数编辑器';//'Function editor';
  sArgument1 = '参数1';//'Argument 1';
  sArgument2 = '参数2';//'Argument 2';
  sArgument3 = '参数3';//'Argument 3';
  sEditor = '编辑器';//'Editor';
  sMemoEditor = 'Memo编辑器';//'Memo editor';
  sUseMemoFontSettings = '设置使用Memo的字体';//'Use Memo font settings';
  sUseFixedFontSettings = '设置使用固定字体';//'Use fixed font settings';
  sScriptEditor = '脚本编辑器';//'Script editor';
  sUseSyntaxHighlight = '使用语法高亮显示';//'Use syntax highlight';
  sReportCorruptOldKnowVersion = '此报表已损坏，可能需要“LRE_OLDV%d_FRF_READ”=true';//'This report is corrupt, it probably needs "LRE_OLDV%d_FRF_READ"=true';
  sReportCorruptUnknownVersion = '此报表已损坏，frVersion=%d';//'This report is corrupt, frVersion=%d';

//--- LR_Intrp resources ---------------------------------------------------
  sErrLine        = '线条';//'Line';
  sErrExpectedEnd = '缺少";" 或 "end"';//'Expected ";" or "end"';
  sErrExpectedThen  = '缺少"then"';//'Expected "then"';
  sErrExpectedUntil = '缺少";" 或 "until"';//'Expected ";" or "until"';
  sErrExpectedDO    = '缺少 "do"';//'Expected "do"';
  sErrLabelGoto     = 'goto中的标签必须是数字';//'Label in goto must be a number';
  sErrExpectedAssign          = '缺少":="';//'Expected ":="';
  sErrExpectedClosingBracket1  = '缺少")"';//'Expected ")"';
  sErrExpectedClosingBracket2  = '缺少 "]"';//'Expected "]"';
  sErrExpectedComma            ='缺少"," or ")"';//'Expected "," or ")"';
  sErrNeedDo                   = '这里必须"do"';//'Need "do" here';
  sErrNeedTo                   = '这里必须"to"';//'Need "to" here';

  // --- Cross-Tab resources -------------------------------------------------

    sCrossTabRowTitle     = '行标题';//'Row title';
    sCrossTabRowTotal     = '行总数';//'Row total';
    sCrossTabColTitle     = '列标题';//'Col title';
    sCrossTabColTotal     = '列总数';//'Col total';
    sCrossTabGranTotal    = '总计';//'Grand total';
    sCrossTabTotalCHCell  = 'CH单元格总数';//'Total CH cell';
    sCrossTabTotalRHCell  = 'RH单元格总数';//'Total RH cell';
    sCrossTabData         = 'Data';


  // --- Cross-Tab editor resources ------------------------------------------

    sCrossEditorCaption   = '交叉表编辑器';//'Cross tab editor';
    sCrossEditorSource    = 'Source data';
    sCrossEditorStructure = '交叉表结构';//'Cross-tab structure';
    sCrossEditorStyle     = '选择样式';//'Select style';
    sCrossEditorNone      = 'None';
    sCrossEditorSum       = 'Sum';
    sCrossEditorMin       = 'Min';
    sCrossEditorMax       = 'Max';
    sCrossEditorAverage   = 'Average';
    sCrossEditorCount     = 'Count';
    sCrossEditorWhite     = '白色';//'White';
    sCrossEditorGray      = '灰色';//'Gray';
    sCrossEditorOrange    = '橙色';//'Orange';
    sCrossEditorGreen     = '绿色';//'Green';
    sCrossEditorGreenOrange = '绿色与橙色';//'Green and Orange';
    sCrossEditorBlue      = '蓝色';//'Blue';
    sCrossEditorBlueWhite = '蓝色与白色';//'Blue and White';
    sCrossEditorCyan      = '青色';//'Cyan';
    sCrossEditorShowColHeader = '显示列标题';//'Show column header';
    sCrossEditorShowColTotal  = '显示列总数';//'Show column total';
    sCrossEditorShowCorner1   = '显示角1';//'Show corner 1';
    sCrossEditorShowRowHeader = '显示行标题';//'Show row header';
    sCrossEditorShowRowTotal  = '后覅行总数';//'Show row total';
    sCrossEditorShowTitle     = '显示标题';//'Show title';
    sCrossEditorShowGranTotal = '显示总计';//'Show grand total';
    sCrossEditorShowCorner2   = '显示角2';//'Show corner 2';

  // --- Data Inspector frame -----------------------------------------------

    sDataInspFields = '字段';//'Fields';
    sDataInspVariables = '变量';//'Variables';

const
  frRes = 53000;

  SInsOLEObject = frRes + 2221;
  SInsRichObject = frRes + 2222;
  SFields = frRes + 2239;
  SPath = frRes + 2240;
  SRemoveDS = frRes + 2241;
  STables = frRes + 2242;
  SFieldType1 = frRes + 2243;
  SFieldType2 = frRes + 2244;
  SFieldType3 = frRes + 2245;
  SFieldType4 = frRes + 2246;
  SFieldType5 = frRes + 2247;
  SFieldType6 = frRes + 2248;
  SFieldType7 = frRes + 2249;
  SFieldType8 = frRes + 2250;
  SFieldType9 = frRes + 2251;
  SFieldType10 = frRes + 2252;
  SParamType1 = frRes + 2270;
  SParamType2 = frRes + 2271;
  SParamType3 = frRes + 2272;
  SParamType4 = frRes + 2273;
  SParamType5 = frRes + 2274;
  SParamType6 = frRes + 2275;
  SParamType7 = frRes + 2276;
  SParamType8 = frRes + 2277;
  SParamType9 = frRes + 2278;
  SParamType10 = frRes + 2279;
  SParamType11 = frRes + 2280;
  SDataManager = frRes + 2300;
  SParams = frRes + 2301;
  SQueryError = frRes + 2302;
  STableProps = frRes + 2303;
  SParamDialog = frRes + 2304;

  SInvalidParamValue = frRes + 2340;
  SDatabase = frRes + 2341;
  SInsRich2Object = frRes + 2343;
  SFieldSizeError = frRes + 2346;


implementation

end.
