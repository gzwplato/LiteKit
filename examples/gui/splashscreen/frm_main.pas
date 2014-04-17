{
  This demonstrates the usage of ICommand and ICommandHolder. They work
  similar to Delphi's TAction classes
}
unit frm_main;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, lq_base, lq_main, lq_form, lq_button,
  lq_memo, lq_menu, lq_label, lq_trackbar;

type

  TMainForm = class(TlqForm)
  private
    {@VFD_HEAD_BEGIN: MainForm}
    btnAdd: TlqButton;
    memName1: TlqMemo;
    btnQuit: TlqButton;
    MainMenu: TlqMenuBar;
    mnuFile: TlqPopupMenu;
    btnShowBorderless: TlqButton;
    btnShowSplash: TlqButton;
    Label1: TlqLabel;
    {@VFD_HEAD_END: MainForm}
  public
    procedure   AfterCreate; override;
  end;


  TBorderLessForm = class(TlqForm)
  private
    {@VFD_HEAD_BEGIN: BorderLessForm}
    btnClose: TlqButton;
    Label1: TlqLabel;
    TrackBar1: TlqTrackBar;
    {@VFD_HEAD_END: BorderLessForm}
  public
    constructor Create(AOwner: TComponent); override;
    procedure   AfterCreate; override;
    class procedure Execute;
  end;

{@VFD_NEWFORM_DECL}

implementation

uses
  lq_command_intf,
  commands;

{@VFD_NEWFORM_IMPL}

{ TBorderLessForm }

constructor TBorderLessForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Include(FWindowAttributes, waBorderLess);  // borderless and steals focus like a normal form
end;

procedure TBorderLessForm.AfterCreate;
begin
  {%region 'Auto-generated GUI code' -fold}
  {@VFD_BODY_BEGIN: BorderLessForm}
  Name := 'BorderLessForm';
  SetPosition(321, 549, 323, 133);
  WindowTitle := 'BorderLessForm';
  Hint := '';
  WindowPosition := wpOneThirdDown;

  btnClose := TlqButton.Create(self);
  with btnClose do
  begin
    Name := 'btnClose';
    SetPosition(232, 100, 80, 24);
    Text := 'Close';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    ModalResult := mrOK;
    TabOrder := 1;
  end;

  Label1 := TlqLabel.Create(self);
  with Label1 do
  begin
    Name := 'Label1';
    SetPosition(8, 32, 304, 16);
    FontDesc := '#Label2';
    Hint := '';
    Layout := tlCenter;
    Text := 'Look Mom, no borders!';
  end;

  TrackBar1 := TlqTrackBar.Create(self);
  with TrackBar1 do
  begin
    Name := 'TrackBar1';
    SetPosition(72, 60, 148, 30);
    Hint := '';
    TabOrder := 3;
  end;

  {@VFD_BODY_END: BorderLessForm}
  {%endregion}
end;

class procedure TBorderLessForm.Execute;
var
  frm: TBorderLessForm;
begin
  frm := TBorderLessForm.Create(nil);
  try
    frm.ShowModal;
  finally
    frm.Free;
  end;
end;


{ TMainForm }

procedure TMainForm.AfterCreate;
begin
  {%region 'Auto-generated GUI code' -fold}
  {@VFD_BODY_BEGIN: MainForm}
  Name := 'MainForm';
  SetPosition(293, 236, 416, 273);
  WindowTitle := 'Command Interface Test';
  Hint := '';
  WindowPosition := wpScreenCenter;

  btnAdd := TlqButton.Create(self);
  with btnAdd do
  begin
    Name := 'btnAdd';
    SetPosition(260, 28, 148, 24);
    Text := 'Add Text to Memo';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    TabOrder := 1;
  end;

  memName1 := TlqMemo.Create(self);
  with memName1 do
  begin
    Name := 'memName1';
    SetPosition(8, 28, 236, 236);
    Hint := '';
    Lines.Add('');
    FontDesc := '#Edit1';
    TabOrder := 2;
  end;

  btnQuit := TlqButton.Create(self);
  with btnQuit do
  begin
    Name := 'btnQuit';
    SetPosition(332, 240, 75, 24);
    Text := 'Quit';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    TabOrder := 3;
  end;

  MainMenu := TlqMenuBar.Create(self);
  with MainMenu do
  begin
    Name := 'MainMenu';
    SetPosition(0, 0, 416, 24);
    Anchors := [anLeft,anRight,anTop];
  end;

  mnuFile := TlqPopupMenu.Create(self);
  with mnuFile do
  begin
    Name := 'mnuFile';
    SetPosition(44, 72, 120, 20);
    AddMenuItem('Quit', '', nil);
  end;

  btnShowBorderless := TlqButton.Create(self);
  with btnShowBorderless do
  begin
    Name := 'btnShowBorderless';
    SetPosition(260, 56, 148, 24);
    Text := 'Show Borderless Form';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    TabOrder := 6;
  end;

  btnShowSplash := TlqButton.Create(self);
  with btnShowSplash do
  begin
    Name := 'btnShowSplash';
    SetPosition(260, 84, 148, 24);
    Text := 'Show Splash Screen';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    TabOrder := 7;
  end;

  Label1 := TlqLabel.Create(self);
  with Label1 do
  begin
    Name := 'Label1';
    SetPosition(252, 120, 156, 116);
    FontDesc := '#Label1';
    Hint := '';
    Text := 'Note the difference between a borderless form and a splash screen (wtPopup) form. wtPopup doesn''t steal focus (eg: hint window)';
    WrapText := True;
  end;

  {@VFD_BODY_END: MainForm}
  {%endregion}

  MainMenu.AddMenuItem('File', nil).SubMenu := mnuFile;

  { Instantiate the Command classes. By setting a Command it
    take preference over OnClick event handlers and is handled
    automatically for you. No need to declare a OnClick event handler. }
  btnAdd.SetCommand(TAddCommand.Create(memName1));
  btnQuit.SetCommand(TExitCommand.Create);
  btnShowBorderless.SetCommand(TShowBorderlessForm.Create);
  btnShowSplash.SetCommand(TShowSplashCommand.Create);
  // The menu item File|Quit shares the command of btnQuit
  mnuFile.MenuItemByName('Quit').SetCommand(btnQuit.GetCommand);
end;


end.
