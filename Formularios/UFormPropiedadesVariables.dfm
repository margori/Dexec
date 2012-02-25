object formPropiedadesVariables: TformPropiedadesVariables
  Left = 449
  Height = 203
  Top = 211
  Width = 304
  Caption = 'New variable'
  ClientHeight = 203
  ClientWidth = 304
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  LCLVersion = '0.9.30'
  object Label1: TLabel
    Left = 45
    Height = 14
    Top = 23
    Width = 29
    Alignment = taRightJustify
    Caption = 'Name'
    ParentColor = False
  end
  object Label2: TLabel
    Left = 49
    Height = 14
    Top = 47
    Width = 25
    Alignment = taRightJustify
    Caption = 'Type'
    ParentColor = False
  end
  object Label3: TLabel
    Left = 20
    Height = 14
    Top = 106
    Width = 54
    Alignment = taRightJustify
    Caption = 'Initial value'
    ParentColor = False
  end
  object Label4: TLabel
    Left = 46
    Height = 14
    Top = 133
    Width = 28
    Alignment = taRightJustify
    Caption = 'Rows'
    ParentColor = False
  end
  object Label5: TLabel
    Left = 151
    Height = 14
    Top = 133
    Width = 41
    Alignment = taRightJustify
    Caption = 'Columns'
    ParentColor = False
  end
  object editNombre: TEdit
    Left = 81
    Height = 21
    Top = 19
    Width = 193
    Anchors = [akTop, akLeft, akRight]
    TabOrder = 0
  end
  object editValorDefecto: TEdit
    Left = 81
    Height = 21
    Top = 102
    Width = 193
    Anchors = [akTop, akLeft, akRight]
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 49
    Height = 25
    Top = 160
    Width = 119
    Kind = bkOK
    ModalResult = 1
    OnClick = BitBtn1Click
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 184
    Height = 25
    Top = 160
    Width = 75
    Kind = bkCancel
    ModalResult = 2
    TabOrder = 3
  end
  object editFilas: TEdit
    Left = 82
    Height = 21
    Top = 129
    Width = 41
    TabOrder = 4
    Text = '1'
  end
  object updownFilas: TUpDown
    Left = 123
    Height = 21
    Top = 129
    Width = 15
    Associate = editFilas
    Min = 1
    Max = 1000
    Position = 1
    TabOrder = 5
    Wrap = False
  end
  object editColumnas: TEdit
    Left = 216
    Height = 21
    Top = 129
    Width = 41
    TabOrder = 6
    Text = '1'
  end
  object updownColumnas: TUpDown
    Left = 257
    Height = 21
    Top = 129
    Width = 15
    Associate = editColumnas
    Min = 1
    Max = 1000
    Position = 1
    TabOrder = 7
    Wrap = False
  end
  object radioEntero: TRadioButton
    Left = 79
    Height = 17
    Top = 48
    Width = 53
    Caption = 'Integer'
    Checked = True
    OnClick = radioEnteroClick
    TabOrder = 8
    TabStop = True
  end
  object radioCadena: TRadioButton
    Left = 79
    Height = 17
    Top = 78
    Width = 47
    Caption = 'String'
    OnClick = radioCadenaClick
    TabOrder = 9
  end
  object radioReal: TRadioButton
    Left = 79
    Height = 17
    Top = 63
    Width = 42
    Caption = 'Real'
    OnClick = radioRealClick
    TabOrder = 10
  end
end
