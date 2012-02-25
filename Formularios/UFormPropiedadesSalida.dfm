object formPropiedadesSalida: TformPropiedadesSalida
  Left = 827
  Height = 259
  Top = 235
  Width = 400
  Caption = 'Properties'
  ClientHeight = 259
  ClientWidth = 400
  Color = clBtnFace
  Constraints.MaxHeight = 259
  Constraints.MinHeight = 259
  Constraints.MinWidth = 292
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  OnCreate = FormCreate
  LCLVersion = '0.9.30'
  object checkCaption: TCheckBox
    Left = 23
    Height = 17
    Top = 28
    Width = 64
    Caption = 'Comment'
    TabOrder = 0
  end
  object checkBreackPoint: TCheckBox
    Left = 23
    Height = 17
    Top = 146
    Width = 82
    Caption = 'Is Breakpoint'
    TabOrder = 1
  end
  object btnOk: TBitBtn
    Left = 47
    Height = 33
    Top = 200
    Width = 202
    Anchors = [akTop, akLeft, akRight]
    Caption = 'Ok'
    Kind = bkOK
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TBitBtn
    Left = 263
    Height = 33
    Top = 200
    Width = 90
    Anchors = [akTop, akRight]
    Kind = bkCancel
    ModalResult = 2
    TabOrder = 3
  end
  object editCaption: TEdit
    Left = 103
    Height = 21
    Top = 26
    Width = 273
    Anchors = [akTop, akLeft, akRight]
    TabOrder = 4
  end
  object checkTexto: TCheckBox
    Left = 23
    Height = 17
    Top = 52
    Width = 73
    Caption = 'Parameters'
    TabOrder = 5
  end
  object editParametros: TEdit
    Left = 103
    Height = 21
    Top = 50
    Width = 275
    Anchors = [akTop, akLeft, akRight]
    TabOrder = 6
  end
  object checkBloquear: TCheckBox
    Left = 23
    Height = 17
    Top = 170
    Width = 123
    Caption = 'Locked. Do not move'
    TabOrder = 7
  end
  object checkRetorno: TCheckBox
    Left = 23
    Height = 17
    Top = 76
    Width = 94
    Caption = 'Carriage Return'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object radioArchivo: TRadioButton
    Left = 23
    Height = 17
    Top = 124
    Width = 36
    Caption = 'File'
    TabOrder = 9
  end
  object radioPantalla: TRadioButton
    Left = 23
    Height = 17
    Top = 100
    Width = 54
    Caption = 'Screen'
    Checked = True
    TabOrder = 10
    TabStop = True
  end
  object editArchivo: TEdit
    Left = 103
    Height = 21
    Top = 122
    Width = 273
    Anchors = [akTop, akLeft, akRight]
    TabOrder = 11
  end
end
