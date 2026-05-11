program miniengine;

{$IFDEF DEBUG}
{$APPTYPE CONSOLE}
{$ELSE}
{$APPTYPE GUI}
{$ENDIF}

{$R *.res}

uses
  System.SysUtils,
  main in 'main.pas',
  sdl2 in 'sdl2.pas',
  ecs in 'ecs.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    RunEngine;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
