unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, CJHooks, StdCtrls, shellapi, Menus, inifiles;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    MyHook1: TMyHook;
    Image3: TImage;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    BlackandWhite1: TMenuItem;
    N6: TMenuItem;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MyHook1KeyDown(sender: TObject; Shift: TCjShiftState;
      Key: Byte);
    procedure FormActivate(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    ammo:boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a:boolean=false;

implementation

{$R *.dfm}

procedure sound(SStart,SSend,SOffset,SLength:integer);
var
j:integer;
begin
if ssend>sstart then
for j:=1  to trunc((ssend-sstart)/soffset) do
begin
windows.Beep(sstart+soffset*j,slength);
yield;
end else
for j:=1  to trunc((sstart-ssend)/soffset) do
begin
windows.Beep(sstart-soffset*j,slength);
yield;
end;

end;


procedure sendkeys(s:string);
var
j:integer;
begin
for j:=1  to length(s) do
begin
keybd_event(vkkeyscan(s[j]), $45, (KEYEVENTF_EXTENDEDKEY or 0), 0);
keybd_event(vkkeyscan(s[j]), $45,  (KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP), 0);
end;
end;
procedure sendkeydown(s:char);
begin
keybd_event(vkkeyscan(s), $45, (KEYEVENTF_EXTENDEDKEY or 0), 0);
end;
procedure sendkeyup(s:char);
begin
keybd_event(vkkeyscan(s), $45,  (KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP), 0);
end;

function GetAdrValue(H:HWND;Addres:cardinal;ByteType:integer;var GetValue:int64):boolean;
var
PID,PH:cardinal;
rw:cardinal;
exec:boolean;
begin
exec:=true;
if h=0 then exec:=false;
getwindowthreadprocessid(h,PID);
PH:=openprocess(process_all_access,false,PID);
if PH=0 then exec:=false;
if readprocessmemory(PH,ptr(Addres),@GetValue,ByteType,rw)=false then exec:=false;
closehandle(PH);
result:=exec;
end;
function SetAdrValue(H:HWND;Addres:cardinal;ByteType:integer;NewValue:int64):boolean;
var
PID,PH:cardinal;
rw:cardinal;
exec:boolean;
begin
exec:=true;
if h=0 then exec:=false;
getwindowthreadprocessid(h,PID);
PH:=openprocess(process_all_access,false,PID);
if PH=0 then exec:=false;
if writeprocessmemory(PH,ptr(Addres),@NewValue,ByteType,rw)=false then exec:=false;
closehandle(PH);
result:=exec;          
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if button=mbMiddle then popupmenu1.Popup(mouse.CursorPos.X,mouse.CursorPos.Y);
if button=mbleft then begin
releasecapture;
sendmessage(handle,wm_syscommand,sc_move+2,0);
end;
end;

procedure TForm1.MyHook1KeyDown(sender: TObject; Shift: TCjShiftState;
  Key: Byte);
const
he=5555;
en=555;
var
h:HWND;
v:int64;
begin
h:=findwindow(nil,'Half-Life 2');
if h<>0then begin
if key=vk_f1 then
begin
          getadrvalue(h,$02760030,4,v);
          setadrvalue(h,v+156,4,he);

          getadrvalue(h,$22544bd8,4,v);
          setadrvalue(h,v+156,4,he);

          getadrvalue(h,$22566edc,4,v);
          setadrvalue(h,v+156,4,he);

          getadrvalue(h,$22589df0,4,v);
          setadrvalue(h,v+156,4,he); //health

          getadrvalue(h,$0275002c,4,v);
          setadrvalue(h,v+2644,4,en);

          getadrvalue(h,$02750030,4,v);
          setadrvalue(h,v+2996,4,en);

          getadrvalue(h,$2254bd8,4,v);
          setadrvalue(h,v+2996,4,en);

          getadrvalue(h,$22566edc,4,v);
          setadrvalue(h,v+2996,4,en);

          getadrvalue(h,$22589df0,4,v);
          setadrvalue(h,v+2996,4,en); //energy
          sound(1400,400,100,20);
end;
if key=vk_f2 then
begin
case ammo of
true:begin
     setadrvalue(h,$22222d59,1,137);
     setadrvalue(h,$22222d59+1,1,156);
     setadrvalue(h,$22222d59+2,1,190);
     setadrvalue(h,$22222d59+3,1,48);
     setadrvalue(h,$22222d59+4,1,6);
     setadrvalue(h,$22222d59+5,1,0);
     setadrvalue(h,$22222d59+6,1,0);

     setadrvalue(h,$220354fe,1,137);
     setadrvalue(h,$220354fe+1,1,174);
     setadrvalue(h,$220354fe+2,1,196);
     setadrvalue(h,$220354fe+3,1,4);
     setadrvalue(h,$220354fe+4,1,0);
     setadrvalue(h,$220354fe+5,1,0);
     sound(1400,400,100,20);
     ammo:=false;
     end;
false:begin
     setadrvalue(h,$22222d59,1,144);
     setadrvalue(h,$22222d59+1,1,144);
     setadrvalue(h,$22222d59+2,1,144);
     setadrvalue(h,$22222d59+3,1,144);
     setadrvalue(h,$22222d59+4,1,144);
     setadrvalue(h,$22222d59+5,1,144);
     setadrvalue(h,$22222d59+6,1,144);

     setadrvalue(h,$220354fe,1,144);
     setadrvalue(h,$220354fe+1,1,144);
     setadrvalue(h,$220354fe+2,1,144);
     setadrvalue(h,$220354fe+3,1,144);
     setadrvalue(h,$220354fe+4,1,144);
     setadrvalue(h,$220354fe+5,1,144);
     sound(400,1400,100,20);
     ammo:=true;
     end;
     end;
end;
end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
showwindow(application.handle,sw_hide);
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
messagebox(handle,'F1 - more health and energy'+#13
           +'F2 - freeze/unfreeze ammo'+#13+#13
           +'Mouse rigth - close'+#13+#13
           +'2006 Cj Technologies'+#153,'Hot Keys',0);
end;

procedure TForm1.Image3Click(Sender: TObject);
const
path='C:\Program Files\Half Life 2\Launcher.exe';
begin
if findwindow(nil,'Half-Life 2')=0 then begin
if fileexists(string(path))=true then
shellapi.ShellExecute(0,nil,path,nil,nil,sw_show)else
messagebox(handle,'Trainer not found the game!'+#13+'Start manually','Error',0);
end else messagebox(handle,'Game is running!','Warning',0);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
application.HintPause:=500;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if button=mbRight then
begin
sound(800,1000,50,15);
sound(1000,400,50,15);
close;
end;
end;

end.
