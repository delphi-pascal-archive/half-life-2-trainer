unit CJHooks;
{
  ------------------------------------------------
 |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
 |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
 |~~~~~~~~~~~~~~>>Cj_Technologies<<~~~~~~~~~~~~~~~|
 |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
 |~~~~~~~компоненты перехвата клавиш ввода~~~~~~~~|
 |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
 |~~~~~~~~~~~~~~Чуклинов Евгений~~~~~~~~~~~~~~~~~~|
 |~~~~~~~~~~~рекомендовано к Dilphi 7~~~~~~~~~~~~~|
 |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
  ------------------------------------------------
}
interface

uses
  Windows,Classes,messages;

type
    TCJNOTIFYEVENTBUTTONSTATE=(cbLeft,cbRight,cbAny,cbIsOne);

    TCJNOTIFYEVENT=procedure(Source:TObject;State:TCJNOTIFYEVENTBUTTONSTATE)of object;

    TSystemKeys=class(TComponent)
    private
           FActive:boolean;
           Handle:HWND;
           FScanInterval:cardinal;
           FShift,FCtrl,FEsc,FWin,FAlt,fonleft,fonup,fondown,fonright:TCJNOTIFYEVENT;
    protected
             procedure SetActive(New:boolean);
             procedure SetInterval(New:cardinal);
             procedure Timer(var Msg:TWMTIMER);message WM_TIMER;
             procedure WndProc(var Msg: TMessage);
    public
          constructor create(aowner:TComponent);override;
          destructor destroy;override;
    published
             property Active:boolean
             read FActive
             write SetActive default false;

             property ScanInterval:cardinal
             read FScanInterval
             write SetInterval default 1;

             property OnShiftPress:TCJNOTIFYEVENT
             read FShift
             write FShift;

             property OnAltPress:TCJNOTIFYEVENT
             read FAlt
             write FAlt;

             property OnCtrlPress:TCJNOTIFYEVENT
             read FCtrl
             write FCtrl;

             property OnWinPress:TCJNOTIFYEVENT
             read FWin
             write FWin;

             property OnEscPress:TCJNOTIFYEVENT
             read FEsc
             write FEsc;

             property OnUpPress:TCJNOTIFYEVENT
             read FOnUp
             write fonup;

             property OnDownPress:TCJNOTIFYEVENT
             read FOndown
             write fondown;

             property OnLeftPress:TCJNOTIFYEVENT
             read FOnleft
             write fonleft;

             property OnRightPress:TCJNOTIFYEVENT
             read FOnRight
             write fonRight;
    end;

    TCjTimer = class(TComponent)
  private
         FActive:boolean;
         FOnTimer:TNotifyEvent;
         FInterval:cardinal;
         Handle:HWND;
  protected
           procedure Timer(var Msg:TMessage);message WM_TIMER;
           procedure SetActive(new:boolean);
           procedure SetInterval(new:cardinal);
           procedure WndProc(var Msg: TMessage);
  public
        constructor Create(AOwner:TComponent);override;
          destructor destroy;override;
  published
           property Interval:cardinal
           read FInterval
           write SetInterval default 1;

           property Active:boolean
           read FActive
           write SetActive default false;

           property OnTimer:TNotifyEvent
           read FOnTimer
           write FOnTimer;
  end;

  TKeyManager = class(TComponent)
  private
  protected
  public
        procedure SendKeys(WindowTitle,Keys:string);overload;
        procedure SendKeys(Handle:HWND;Keys:string);overload;
        procedure SendKey(WindowTitle:string;Key:word);overload;
        procedure SendKey(Handle:HWND;Key:word);overload;
        procedure SimulateKeys(Keys:string);
        function KeyNow:word;
        function KeyState(key1:word):boolean;overload;
        function KeysState(key1,key2:word):boolean;overload;
        function KeysState(key1,key2,key3:word):boolean;overload;
  published
  end;

      TCjShiftState=set of(cssShift,cssRShift,cssLShift,
      cssControl,cssRControl,cssLControl,cssAlt,cssRAlt,
      cssLAlt,cssWin,cssRWin,cssLWin,cssEsc,cssContext,
      cssMouse,cssLMouse,cssRMouse,cssMMouse);

    TKeys=array[1..255]of boolean;

  TKeyEvent=procedure(sender:TObject;key:TKeys)of object;

  TExtendedKeyEvent=procedure(sender:TObject;Shift:TCjShiftState;key:TKeys)of object;

  TKeyViewer = class(TComponent)
  private
         FActive:boolean;
         Fons:TKeyevent;
         FOnd,Fonu,fonp:TExtendedKeyEvent;
         FINt:cardinal;
         Handle:HWND;
         pr:array[1..255]of boolean;
  protected
           procedure SetActive(new:boolean);
           procedure Timer(var Msg:TMessage);message WM_TIMER;
           procedure SetInterval(new:cardinal);
           function keystate(key1:word):boolean;
           procedure WndProc(var Msg: TMessage);
  public
           procedure hook;
        constructor Create(aowner:TComponent);override;
          destructor destroy;override;
  published
           property Active:boolean
           read FActive
           write SetActive default false;

           property ScanInterval:cardinal
           read Fint
           write SetInterval default 1;

           property OnKeyScan:TKeyEvent
           read Fons
           write FONs;

           property OnKeyDown:TExtendedKeyEvent
           read Fond
           write FONd;

           property OnKeyPress:TExtendedKeyEvent
           read Fonp
           write FONp;

           property OnKeyUp:TExtendedKeyEvent
           read Fonu
           write FONu;
  end;

    THookKeyEvent=procedure(sender:TObject;Shift:TCjShiftState;Key:byte)of object;

  TMyHook = class(TComponent)
  private
         FActive:boolean;
         FOnKeyDown,FOnKeyPress,FOnKeyUp:THookKeyEvent;
         handle:HWND;
         FInterval:integer;
         pr:array[1..255]of boolean;
         FHW:HWND;
  protected
           procedure SetActive(new:boolean);
           procedure Hook(var Msg:TMessage);message WM_TIMER;
           procedure setinterval(new:integer);
           procedure WndProc(var Msg: TMessage);
  public
           constructor Create(aowner:TComponent);override;
          destructor destroy;override;
  published
           property Active:boolean
           read FActive
           write SetActive default false;

           property HookWindow:HWND
           read FHW;

           property OnKeyDown:THookKeyEvent
           read FOnKeyDown
           write FOnKeyDown;

           property OnKeyPress:THookKeyEvent
           read FOnKeyPress
           write FOnKeyPress;

           property OnKeyUp:THookKeyEvent
           read FOnKeyUp
           write FOnKeyUp;

           property ScanInterval:integer
           read FInterval
           write SetInterval default 1;
  end;

const

{Cj Key Const's}
     key_escape=27;
     
     key_f1=112;
     key_f2=113;
     key_f3=114;
     key_f4=115;
     key_f5=116;
     key_f6=117;
     key_f7=118;
     key_f8=119;
     key_f9=120;
     key_f10=121;
     key_f11=122;
     key_f12=123;

     key_print_screen=44;
     key_Scroll_lock=145;
     key_pause=19;

     key_0=48;
     key_1=49;
     key_2=50;
     key_3=51;
     key_4=52;
     key_5=53;
     key_6=54;
     key_7=55;
     key_8=56;
     key_9=57;

     key_delete=46;
     key_home=36;
     key_page_up=33;
     key_page_down=34;
     key_end=35;
     key_tab=9;
     key_caps_lock=20;
     key_insert=45;
     key_context_menu=93;
     key_return=13;
     key_space=32;
     key_backspace=8;

     //controls,shifts,windows,alts
     key_shift=16;
     key_left_shift=160;
     key_right_shift=161;
     key_control=17;
     key_left_control=162;
     key_right_control=163;
     key_left_alt=164;
     key_right_alt=165;
     key_alt=18;
     key_left_windows=91;
     key_right_windows=92;

     //arrows
     key_left_arrow=37;
     key_up_arrow=38;
     key_right_arrow=39;
     key_down_arrow=40;

     //num pad
     key_num_lock=145;
     key_num_divide=111;
     key_num_multiply=106;
     key_num_decrease=109;
     key_num_increase=107;
     key_num_delete=96;
     key_num0=96;
     key_num1=97;
     key_num2=98;
     key_num3=99;
     key_num4=100;
     key_num5=101;
     key_num6=102;
     key_num7=103;
     key_num8=104;
     key_num9=105;

     //mouse
     mouse_button_left=1;
     mouse_button_right=2;
     mouse_button_middle=3;

     key_mouse_left=mouse_button_left;
     key_mouse_right=mouse_button_right;
     key_mouse_middle=mouse_button_middle;

     //extendedkeys
     key_volume_mute=173;
     key_volume_inc=175;
     key_volume_dec=174;

     key_mail=172;
     key_sleep_mode=95;
     key_play=179;
     key_stop=178;
     key_backward=177;
     key_forward=176;
     key_run=171;
     key_programs=255;

procedure Register;

function KeyCode(Key:char):byte;

implementation

function KeyCode(Key:char):byte;
begin
case key of
chr(65)..chr(90):result:=ord(key);
chr(97)..chr(122):result:=ord(upcase(key));
'`':result:=192;
'1':result:=49;
'2':result:=50;
'3':result:=51;
'4':result:=52;
'5':result:=53;
'6':result:=54;
'7':result:=55;
'8':result:=56;
'9':result:=57;
'0':result:=48;
'-':result:=189;
'=':result:=187;
'[':result:=219;
']':result:=221;
';':result:=186;
'''':result:=222;
',':result:=188;
'.':result:=190;
'/':result:=191;
'\':result:=220;
' ':result:=32;
else result:=0;
end;
end;

destructor TSystemkeys.destroy;
begin
inherited destroy;
killtimer(handle,1);
{$IFDEF MSWINDOWS}
Classes.DeallocateHWnd(Handle);
{$ENDIF}
end;
destructor TCjtimer.destroy;
begin
inherited destroy;
killtimer(handle,1);
{$IFDEF MSWINDOWS}
Classes.DeallocateHWnd(Handle);
{$ENDIF}
end;
destructor TKeyViewer.destroy;
begin
inherited destroy;
killtimer(handle,1);
{$IFDEF MSWINDOWS}
Classes.DeallocateHWnd(Handle);
{$ENDIF}
end;
destructor TMyhook.destroy;
begin
inherited destroy;
killtimer(handle,1);
{$IFDEF MSWINDOWS}
Classes.DeallocateHWnd(Handle);
{$ENDIF}
end;

constructor TSystemKeys.create(aowner:TComponent);
begin
inherited create(aowner);
FActive:=false;
FscanInterval:=1;
{$IFDEF MSWINDOWS}
  Handle := Classes.AllocateHWnd(WndProc);
{$ENDIF}
end;

procedure TSystemKeys.WndProc(var Msg: TMessage);
var
m:TWMTIMER;
begin
if Msg.Msg = WM_TIMER then Timer(m);
end;

procedure TSystemKeys.Timer(var Msg:TWMTIMER);
function keystate(key:byte):boolean;
begin
if (getkeystate(key)=-128)or
   (getkeystate(key)=-127)then result:=true else result:=false;
end;
begin
if keystate(key_shift)then if assigned(OnShiftPress)then OnShiftPress(self,cbAny);
if keystate(key_alt)then if assigned(OnAltPress)then OnAltPress(self,cbAny);
if keystate(key_control)then if assigned(OnCtrlPress)then OnCtrlPress(self,cbAny);
if (keystate(key_left_windows))or(keystate(vk_rwin))then if assigned(OnWinPress)then OnWinPress(self,cbLeft);
if keystate(key_left_shift)then if assigned(OnShiftPress)then OnShiftPress(self,cbLeft);
if keystate(key_left_alt)then if assigned(OnAltPress)then OnAltPress(self,cbLeft);
if keystate(key_left_control)then if assigned(OnCtrlPress)then OnCtrlPress(self,cbLeft);
if (keystate(key_left_windows))then if assigned(OnWinPress)then OnWinPress(self,cbLeft);
if keystate(key_Right_shift)then if assigned(OnShiftPress)then OnShiftPress(self,cbRight);
if keystate(key_right_alt)then if assigned(OnAltPress)then OnAltPress(self,cbRight);
if keystate(key_right_control)then if assigned(OnCtrlPress)then OnCtrlPress(self,cbRight);
if (keystate(key_right_windows))then if assigned(OnWinPress)then OnWinPress(self,cbRight);
if keystate(key_escape)then if assigned(OnEscPress)then OnEscPress(self,cbIsOne);
if keystate(key_left_arrow)then if assigned(onleftpress)then onleftpress(self,cbIsOne);
if keystate(key_right_arrow)then if assigned(onrightpress)then onrightpress(self,cbIsOne);
if keystate(key_up_arrow)then if assigned(onuppress)then onuppress(self,cbIsOne);
if keystate(key_down_arrow)then if assigned(ondownpress)then ondownpress(self,cbIsOne);
end;

procedure TSystemKeys.SetActive(New:boolean);
begin
FActive:=new;
if new=true then begin
                      killtimer(handle,1);
                      settimer(handle,1,ScanInterval,nil)
                 end else killtimer(handle,1);
end;

procedure TSystemKeys.SetInterval(New:cardinal);
begin
FScanInterval:=new;
if active then      begin
                    killtimer(handle,1);
                    settimer(handle,1,new,nil);
                    end;
end;

procedure TCjTimer.WndProc(var Msg: TMessage);
var
m:TMESSAGE;
begin
if Msg.Msg = WM_TIMER then Timer(m);
end;

procedure TCjTimer.Timer(var Msg:TMessage);
begin
if assigned(ontimer)then ontimer(self);
end;

constructor TCjTimer.Create(AOwner:TComponent);
begin
inherited Create(Aowner);
FInterval:=1;
FActive:=false;
{$IFDEF MSWINDOWS}   
  Handle := Classes.AllocateHWnd(WndProc);
{$ENDIF}
end;

procedure TCjTimer.SetInterval(new:cardinal);
begin
FInterval:=new;
if active=false then killtimer(handle,1);
if active=true then settimer(handle,1,interval,nil);
end;

procedure TCjTimer.SetActive(new:boolean);
begin
FActive:=new;
if new=true then begin
                      killtimer(handle,1);
                      settimer(handle,1,interval,nil);
                 end else killtimer(handle,1);
end;


procedure TMyHook.SetActive(new:boolean);
begin
FActive:=new;
case active of
true:settimer(Handle,1,1,nil);
false:killtimer(Handle,1);
end;
end;

procedure TMyHook.setinterval(new:integer);
begin
FInterval:=new;
if active=true then begin
                    killtimer(handle,1);
                    settimer(handle,1,new,nil);
                    end;
end;

procedure TMyHook.Hook(var Msg:TMessage);
function keystate(key1:byte):boolean;
begin
if (getkeystate(key1)=-128)or
   (getkeystate(key1)=-127)then result:=true else result:=false;
end;
function SS:TCjShiftState;
var
s:TCjShiftState;
begin
s:=[];
if keystate(key_shift)then s:=s+[cssShift];
if keystate(key_left_shift)then s:=s+[cssLShift];
if keystate(key_right_shift)then s:=s+[cssRShift];
if keystate(key_control)then s:=s+[cssControl];
if keystate(key_left_control)then s:=s+[cssLControl];
if keystate(key_right_control)then s:=s+[cssRControl];
if keystate(key_alt)then s:=s+[cssalt];
if keystate(key_left_alt)then s:=s+[cssLAlt];
if keystate(key_right_alt)then s:=s+[cssRalt];
if keystate(key_left_windows)or
   keystate(key_right_windows)then s:=s+[cssWin];
if keystate(key_left_windows)then s:=s+[cssLWin];
if keystate(key_right_windows)then s:=s+[cssRWin];
if keystate(key_escape)then s:=s+[cssEsc];
if keystate(key_context_menu)then s:=s+[cssContext];
if keystate(mouse_button_left)then s:=s+[cssLMouse];
if keystate(mouse_button_right)then s:=s+[cssRMouse];
if keystate(mouse_button_middle)then s:=s+[cssMMouse];
if keystate(mouse_button_left)or
   keystate(mouse_button_right)or
   keystate(mouse_button_middle)then s:=s+[cssMouse];
SS:=s;
end;
procedure dow(k:byte);
begin
{down}
FHW:=getforegroundwindow;
if assigned(onkeydown)then onkeydown(self,ss,k);
if assigned(onkeypress)then onkeypress(self,ss,k)
end;
procedure pre(k:byte);
begin
{press}
FHW:=getforegroundwindow;
if assigned(onkeypress)then onkeypress(self,ss,k);
end;
procedure up(k:byte);
begin
{up}
FHW:=getforegroundwindow;
if assigned(onkeyup)then onkeyup(self,ss,k);
end;

var
j:integer;
begin
for j:=1 to 255 do
begin
if (keystate(j)=true)and(pr[j]=false)then
   begin
   pr[j]:=true;
   {down}
   dow(j);
   end else if (keystate(j)=true)and(pr[j]=true)then {pressed}pre(j)else
       if (keystate(j)=false)and(pr[j]=true)then
            begin
                 pr[j]:=false;
                 up(j);
                 {up}
            end;
end;

end;

constructor TMyHook.Create(aowner:TComponent);
var
j:integer;
begin
inherited Create(aowner);
FActive:=false;
FInterval:=1;
FHW:=0;
for j:=1  to 255 do
begin
pr[j]:=false;
end;

{$IFDEF MSWINDOWS}
  Handle := Classes.AllocateHWnd(WndProc);
{$ENDIF}
end;

procedure TMyHook.WndProc(var Msg: TMessage);
var
m:TMESSAGE;
begin
if Msg.Msg = WM_TIMER then Hook(m);
end;

function TKeyViewer.keystate(key1:word):boolean;
begin
if (getkeystate(key1)=-128)or
   (getkeystate(key1)=-127)then result:=true else result:=false;
end;

procedure TKeyViewer.SetInterval(new:cardinal);
begin
if active=true then begin
                         killtimer(handle,1);
                         settimer(handle,1,new,nil);
                    end;
FINT:=new;
end;

procedure TKeyViewer.Hook;
var
m:TMessage;
begin
timer(m);
end;

procedure TKeyViewer.Timer(var Msg:TMessage);
function keystate(key1:byte):boolean;
begin
if (getkeystate(key1)=-128)or
   (getkeystate(key1)=-127)then result:=true else result:=false;
end;
function SS:TCjShiftState;
var
s:TCjShiftState;
begin
s:=[];
if keystate(key_shift)then s:=s+[cssShift];
if keystate(key_left_shift)then s:=s+[cssLShift];
if keystate(key_right_shift)then s:=s+[cssRShift];
if keystate(key_control)then s:=s+[cssControl];
if keystate(key_left_control)then s:=s+[cssLControl];
if keystate(key_right_control)then s:=s+[cssRControl];
if keystate(key_alt)then s:=s+[cssalt];
if keystate(key_left_alt)then s:=s+[cssLAlt];
if keystate(key_right_alt)then s:=s+[cssRalt];
if keystate(key_left_windows)or
   keystate(key_right_windows)then s:=s+[cssWin];
if keystate(key_left_windows)then s:=s+[cssLWin];
if keystate(key_right_windows)then s:=s+[cssRWin];
if keystate(key_escape)then s:=s+[cssEsc];
if keystate(key_context_menu)then s:=s+[cssContext];
if keystate(mouse_button_left)then s:=s+[cssLMouse];
if keystate(mouse_button_right)then s:=s+[cssRMouse];
if keystate(mouse_button_middle)then s:=s+[cssMMouse];
if keystate(mouse_button_left)or
   keystate(mouse_button_right)or
   keystate(mouse_button_middle)then s:=s+[cssMouse];
SS:=s;
end;
procedure dow(k:TKeys);
begin
if assigned(onkeydown)then onkeydown(self,ss,k);
end;
procedure pre(k:TKeys);
begin
{press}
if assigned(onkeypress)then onkeypress(self,ss,k);
end;
procedure up(k:TKeys);
begin
if assigned(onkeyup)then onkeyup(self,ss,k);
end;
function ks:TKeys;
var
s:TKeys;
j:integer;
begin
for j:=1  to 255 do
begin
s[j]:=false;
s[j]:=keystate(j);
end;
ks:=s;
end;

var
j:integer;
k:TKeys;
begin
for j:=1  to 255 do
begin
k[j]:=keystate(j);
if (k[j]=true)and(pr[j]=false)then
   begin
   pr[j]:=true;
   {down}
   dow(ks);
   end else if (k[j]=true)and(pr[j]=true)then {pressed}pre(ks)else if (k[j]=false)and(pr[j]=true)then
            begin
                 pr[j]:=false;
                 up(ks);
                 {up}
            end;
end;
if assigned(onkeyscan)then onkeyscan(self,ks);
end;

constructor TKeyViewer.Create(aowner:TComponent);
begin
inherited Create(aowner);
FActive:=false;
FINT:=1;
{$IFDEF MSWINDOWS}
  Handle := Classes.AllocateHWnd(WndProc);
{$ENDIF}
end;

procedure TKeyViewer.WndProc(var Msg: TMessage);
var
m:TMESSAGE;
begin
if Msg.Msg = WM_TIMER then Timer(m);
end;

procedure TKeyViewer.SetActive(new:boolean);
begin
FActive:=new;
if FActive=true then settimer(handle,1,1,nil)else killtimer(handle,1);
end;

procedure TKeyManager.SendKeys(WindowTitle,Keys:string);
var
h:HWND;
j:integer;
begin
h:=findwindow(nil,pchar(WindowTitle));
for j:=1  to length(keys) do
begin
SendMessage(h,WM_KEYDOWN,VkKeyScan(keys[j]),0);
SendMessage(h,WM_KEYUP,VkKeyScan(keys[j]),0);
end;
end;
procedure TKeyManager.SendKeys(Handle:HWND;Keys:string);
var
j:integer;
begin
for j:=1  to length(keys) do
begin
SendMessage(handle,WM_KEYDOWN,VkKeyScan(keys[j]),0);
SendMessage(handle,WM_KEYUP,VkKeyScan(keys[j]),0);
end;
end;
procedure TKeyManager.SimulateKeys(Keys:string);
var
j:integer;
begin
for j:=1  to length(keys) do
begin
keybd_event(vkkeyscan(keys[j]), $45, (KEYEVENTF_EXTENDEDKEY or 0), 0);
keybd_event(vkkeyscan(keys[j]), $45,  (KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP), 0);
end;
end;

procedure TKeyManager.SendKey(WindowTitle:string;Key:word);
var
h:HWND;
begin
h:=findwindow(nil,pchar(WindowTitle));
SendMessage(h,WM_KEYDOWN,key,0);
SendMessage(h,WM_KEYUP,key,0);
end;
procedure TKeyManager.SendKey(Handle:HWND;Key:word);
begin
SendMessage(handle,WM_KEYDOWN,key,0);
SendMessage(handle,WM_KEYUP,key,0);
end;

function TKeyManager.keynow:word;
var
j:word;
begin
for j:=1  to 255 do
begin
if keystate(j)=true then begin
                         keynow:=j;
                         exit;
                         end;
end;
keynow:=0;
end;

function TKeyManager.keystate(key1:word):boolean;
begin
if (getkeystate(key1)=-128)or
   (getkeystate(key1)=-127)then result:=true else result:=false;
end;
function TKeyManager.keysstate(key1,key2:word):boolean;
begin
if ((getkeystate(key1)=-128)or
   (getkeystate(key1)=-127))and
   ((getkeystate(key2)=-128)or
   (getkeystate(key2)=-127))then result:=true else result:=false;
end;
function TKeyManager.keysstate(key1,key2,key3:word):boolean;
begin
if ((getkeystate(key1)=-128)or
   (getkeystate(key1)=-127))and
   ((getkeystate(key2)=-128)or
   (getkeystate(key2)=-127))and
   ((getkeystate(key3)=-128)or
   (getkeystate(key3)=-127))
   then result:=true else result:=false;
end;

procedure Register;
begin
  RegisterComponents('CjUtils', [TKeyManager,TKeyViewer,TSystemKeys,TMyHook,TCjTimer]);
end;

end.
 