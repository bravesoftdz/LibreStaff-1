unit FrameAddDelEdiSavCan;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, ExtCtrls, Buttons, StdCtrls;

type

  { TFraAddDelEdiSavCan }

  TFraAddDelEdiSavCan = class(TFrame)
    BtnEdit: TBitBtn;
    BtnDelete: TBitBtn;
    BtnAdd: TBitBtn;
    BtnCancel: TBitBtn;
    BtnSave: TBitBtn;
    LblNavRec: TLabel;
    PanBottom: TPanel;
  private
    { private declarations }
  public
    { public declarations }
  protected
		procedure Loaded; override;
  end;

implementation

{$R *.lfm}

uses
  FormMain;

procedure TFraAddDelEdiSavCan.Loaded;
begin
  inherited;
  FrmMain.ImgLstBtn.GetBitmap(3, BtnSave.Glyph);
  FrmMain.ImgLstBtn.GetBitmap(2, BtnCancel.Glyph);
  FrmMain.ImgLstBtn.GetBitmap(11, BtnAdd.Glyph);
  FrmMain.ImgLstBtn.GetBitmap(10, BtnDelete.Glyph);
  FrmMain.ImgLstBtn.GetBitmap(12, BtnEdit.Glyph);
end;
end.
