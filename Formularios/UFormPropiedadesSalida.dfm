object formPropiedadesSalida: TformPropiedadesSalida
  Left = 349
  Height = 259
  Top = 246
  Width = 320
  Caption = 'Properties'
  ClientHeight = 259
  ClientWidth = 320
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
    Left = 15
    Height = 17
    Top = 18
    Width = 64
    Caption = 'Comment'
    TabOrder = 0
  end
  object checkBreackPoint: TCheckBox
    Left = 15
    Height = 17
    Top = 136
    Width = 71
    Caption = 'Breakpoint'
    TabOrder = 1
  end
  object btnOk: TBitBtn
    Left = 32
    Height = 25
    Top = 190
    Width = 140
    Anchors = [akTop, akLeft, akRight]
    Caption = 'Ok'
    Kind = bkOK
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TBitBtn
    Left = 180
    Height = 25
    Top = 190
    Width = 120
    Anchors = [akTop, akRight]
    Kind = bkCancel
    ModalResult = 2
    TabOrder = 3
  end
  object editCaption: TEdit
    Left = 95
    Height = 21
    Top = 16
    Width = 211
    Anchors = [akTop, akLeft, akRight]
    TabOrder = 4
  end
  object checkTexto: TCheckBox
    Left = 15
    Height = 17
    Top = 42
    Width = 73
    Caption = 'Parameters'
    TabOrder = 5
  end
  object editParametros: TEdit
    Left = 95
    Height = 21
    Top = 40
    Width = 211
    Anchors = [akTop, akLeft, akRight]
    TabOrder = 6
  end
  object checkBloquear: TCheckBox
    Left = 15
    Height = 17
    Top = 160
    Width = 81
    Caption = 'Do not move'
    TabOrder = 7
  end
  object checkRetorno: TCheckBox
    Left = 15
    Height = 17
    Top = 66
    Width = 52
    Caption = 'Return'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object radioArchivo: TRadioButton
    Left = 15
    Height = 17
    Top = 114
    Width = 36
    Caption = 'File'
    TabOrder = 9
  end
  object radioPantalla: TRadioButton
    Left = 15
    Height = 17
    Top = 90
    Width = 54
    Caption = 'Screen'
    Checked = True
    TabOrder = 10
    TabStop = True
  end
  object editArchivo: TEdit
    Left = 95
    Height = 21
    Top = 112
    Width = 209
    Anchors = [akTop, akLeft, akRight]
    TabOrder = 11
  end
end
