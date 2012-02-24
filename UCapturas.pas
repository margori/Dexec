unit UCapturas;

interface

uses Forms;

type
  TCapturas = class
    class procedure Capturar(AForm : TForm);
  end;

implementation

uses Graphics, Types;

class procedure TCapturas.Capturar(AForm : TForm);
var
	LBitmap : TBitmap;
	w,h : integer;
	DC : HDC;
	hWin : Cardinal;
	r : TRect;
	LVisible: Boolean;
begin
	LVisible := AForm.Visible;

	AForm.Show;
	AForm.Repaint;

	hWin := AForm.Handle;
	dc := GetWindowDC(hWin) ;
	GetWindowRect(hWin,r) ;
	w := r.Right - r.Left;
	h := r.Bottom - r.Top;

	LBitmap := TBitmap.Create;
	try
		LBitmap.Width := w;
		LBitmap.Height := h;
		BitBlt(LBitmap.Canvas.Handle, 0, 0, LBitmap.Width, LBitmap.Height, DC, 0, 0, SRCCOPY) ;
	 finally
		ReleaseDC(hWin, DC) ;
	 end;

	LBitmap.SaveToFile(AForm.Name + '.bmp');
	LBitmap.Free;

	if Not LVisible then
		AForm.Hide;
end;

end.