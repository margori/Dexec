object FormPropiedades: TFormPropiedades
  Left = 429
  Height = 182
  Top = 229
  Width = 400
  Caption = 'Properties'
  ClientHeight = 182
  ClientWidth = 400
  Color = clBtnFace
  Constraints.MaxHeight = 182
  Constraints.MinHeight = 182
  Constraints.MinWidth = 290
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  OnCreate = FormCreate
  OnShow = FormShow
  Position = poScreenCenter
  LCLVersion = '0.9.30.2'
  object checkCaption: TCheckBox
    Left = 18
    Height = 21
    Top = 25
    Width = 78
    Caption = 'Comment'
    TabOrder = 0
  end
  object checkBreackPoint: TCheckBox
    Left = 18
    Height = 21
    Top = 74
    Width = 84
    Caption = 'Breakpoint'
    TabOrder = 4
  end
  object btnOk: TBitBtn
    Left = 50
    Height = 33
    Top = 127
    Width = 202
    Anchors = [akTop, akLeft, akRight]
    Caption = '&Ok'
    Kind = bkOK
    ModalResult = 1
    OnClick = btnOkClick
    TabOrder = 6
  end
  object btnCancel: TBitBtn
    Left = 261
    Height = 33
    Top = 127
    Width = 90
    Anchors = [akTop, akRight]
    Kind = bkCancel
    ModalResult = 2
    TabOrder = 7
  end
  object editCaption: TEdit
    Left = 110
    Height = 23
    Top = 23
    Width = 273
    Anchors = [akTop, akLeft, akRight]
    TabOrder = 1
  end
  object checkTexto: TCheckBox
    Left = 18
    Height = 21
    Top = 49
    Width = 76
    Caption = 'Instrution'
    TabOrder = 2
  end
  object editTexto: TEdit
    Left = 110
    Height = 23
    Top = 47
    Width = 273
    Anchors = [akTop, akLeft, akRight]
    TabOrder = 3
  end
  object checkBloquear: TCheckBox
    Left = 18
    Height = 21
    Top = 94
    Width = 100
    Caption = 'Do not move.'
    TabOrder = 5
  end
end