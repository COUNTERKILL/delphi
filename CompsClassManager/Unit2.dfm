object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Manage Computer'
  ClientHeight = 212
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    Left = 8
    Top = 64
    Width = 17
    Height = 19
    Caption = 'IP:'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
  end
  object sLabel2: TsLabel
    Left = 72
    Top = 64
    Width = 60
    Height = 19
    Caption = '127.0.0.1'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
  end
  object sLabel3: TsLabel
    Left = 8
    Top = 31
    Width = 40
    Height = 19
    Caption = 'Name:'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
  end
  object sLabel4: TsLabel
    Left = 8
    Top = 8
    Width = 40
    Height = 19
    Caption = 'Status:'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
  end
  object sLabel5: TsLabel
    Left = 72
    Top = 8
    Width = 39
    Height = 19
    Caption = 'Online'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
    UseSkinColor = False
  end
  object sLabel6: TsLabel
    Left = 98
    Top = 121
    Width = 32
    Height = 19
    Caption = 'Time:'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
  end
  object sButton1: TsButton
    Left = 8
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Restart'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = sButton1Click
    SkinData.SkinSection = 'BUTTON'
    ShowFocus = False
  end
  object sEdit1: TsEdit
    Left = 72
    Top = 31
    Width = 201
    Height = 26
    AutoSize = False
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = sEdit1Change
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object sButton2: TsButton
    Left = 198
    Top = 63
    Width = 75
    Height = 26
    Caption = 'Update IP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = sButton2Click
    SkinData.SkinSection = 'BUTTON'
    ShowFocus = False
  end
  object sButton3: TsButton
    Left = 208
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Start RDP'
    TabOrder = 3
    OnClick = sButton3Click
    SkinData.SkinSection = 'BUTTON'
    ShowFocus = False
  end
  object sCheckBox1: TsCheckBox
    Left = 8
    Top = 184
    Width = 55
    Height = 19
    Caption = 'Force'
    Checked = True
    State = cbChecked
    TabOrder = 4
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
    ShowFocus = False
  end
  object sButton4: TsButton
    Left = 8
    Top = 156
    Width = 75
    Height = 25
    Caption = 'Shutdown'
    TabOrder = 5
    OnClick = sButton4Click
    SkinData.SkinSection = 'BUTTON'
    ShowFocus = False
  end
  object sEdit2: TsEdit
    Left = 136
    Top = 122
    Width = 41
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 6
    Text = '0'
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
end
