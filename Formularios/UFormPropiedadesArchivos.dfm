object formPropiedadesArchivos: TformPropiedadesArchivos
  Left = 315
  Height = 170
  Top = 259
  Width = 410
  Caption = 'File'
  ClientHeight = 170
  ClientWidth = 410
  Color = clBtnFace
  Constraints.MaxHeight = 170
  Constraints.MinHeight = 170
  Constraints.MinWidth = 410
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  OnCreate = FormCreate
  LCLVersion = '0.9.30'
  object Label1: TLabel
    Left = 29
    Height = 14
    Top = 61
    Width = 23
    Caption = 'Path'
    ParentColor = False
  end
  object Label2: TLabel
    Left = 21
    Height = 14
    Top = 93
    Width = 36
    Caption = 'Access'
    ParentColor = False
  end
  object Label3: TLabel
    Left = 21
    Height = 14
    Top = 29
    Width = 29
    Caption = 'Name'
    ParentColor = False
  end
  object editRuta: TEdit
    Left = 61
    Height = 21
    Top = 57
    Width = 296
    Anchors = [akTop, akLeft, akRight]
    TabOrder = 0
  end
  object btnExaminar: TButton
    Left = 357
    Height = 21
    Top = 57
    Width = 33
    Anchors = [akTop, akRight]
    Caption = '...'
    OnClick = btnExaminarClick
    TabOrder = 1
  end
  object comboAcceso: TComboBox
    Left = 61
    Height = 21
    Top = 89
    Width = 294
    ItemHeight = 13
    Items.Strings = (
      'Read'
      'Rewrite / create'
      'Write'
    )
    Style = csDropDownList
    TabOrder = 2
  end
  object btnOk: TBitBtn
    Left = 101
    Height = 25
    Top = 121
    Width = 120
    Anchors = [akTop, akLeft, akRight]
    Kind = bkOK
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TBitBtn
    Left = 229
    Height = 25
    Top = 121
    Width = 75
    Anchors = [akTop, akRight]
    Kind = bkCancel
    ModalResult = 2
    TabOrder = 4
  end
  object editNombre: TEdit
    Left = 61
    Height = 21
    Top = 25
    Width = 329
    Anchors = [akTop, akLeft, akRight]
    TabOrder = 5
  end
  object SaveDialog1: TSaveDialog
    Filter = 'All file (*.*)|*.*|Data files (*.dat)|*.dat|Input files (*.in)|*.in|Output files (*.out)|*.out|Text files (*.txt)|*.txt'
    left = 309
    top = 89
  end
end
