program ${PROJECTNAME};

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, lq_main, lq_form;

type

  TMainForm = class(TlqForm)
  public
    {@VFD_HEAD_BEGIN: MainForm}
    {@VFD_HEAD_END: MainForm}
    procedure AfterCreate; override;
  end;

{@VFD_NEWFORM_DECL}



{@VFD_NEWFORM_IMPL}

procedure TMainForm.AfterCreate;
begin
  {@VFD_BODY_BEGIN: MainForm}
  Name := 'MainForm';
  SetPosition(316, 186, 300, 250);
  WindowTitle := 'MainForm';

  {@VFD_BODY_END: MainForm}
end;


procedure MainProc;
var
  frm: TMainForm;
begin
  lqApplication.Initialize;
  frm := TMainForm.Create(nil);
  try
    frm.Show;
    lqApplication.Run;
  finally
    frm.Free;
  end;
end;

begin
  MainProc;
end.


