unit raylib_descriptors;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, Forms, LazIDEIntf, ProjectIntf, MenuIntf;

type
  { TRayGameSimpleProjectDescriptor }
  TRaySimpleProjectDescriptor = class(TProjectDescriptor)
  public
    constructor Create; override;
    function GetLocalizedName: string; override;
    function GetLocalizedDescription: string; override;
    function InitProject(AProject: TLazProject): TModalResult; override;
    function CreateStartFiles(AProject: TLazProject): TModalResult; override;
  end;

  procedure Register;

implementation
 uses raylib;

procedure ShowAbout(Sender: TObject);
const message= 'This sample illustrates a text writing\nanimation effect! Check it out! ;)';
var
  framesCounter:integer;
begin
 InitWindow(480 , 200, 'about raylib...');
 SetTargetFPS(60);
 framesCounter := 0;
 while not WindowShouldClose() do
 begin
 inc(framesCounter);
 BeginDrawing();
 ClearBackground(RAYWHITE);
 DrawText(TextSubtext('raylib pascal bindings',0, framesCounter div 4), 20, 20, 20, DARKGRAY);
 DrawLine(20, 50, 460, 50, DARKGRAY);
 DrawText(TextSubtext('contributions:',0, framesCounter div 8), 20, 60, 10, DARKGRAY);
 DrawText(TextSubtext('Donald Duvall (tazdij)', 0, framesCounter div 9), 100, 60, 10, DARKGRAY);
 DrawText(TextSubtext('Vadim Gunko (Guva)' , 0, framesCounter div 10), 100, 75, 10, DARKGRAY);
 DrawText(TextSubtext('Ludo (ludoza)' , 0, framesCounter div 11), 100, 90, 10, DARKGRAY);
 DrawText(TextSubtext('Zaher Dirkey (zaher)' , 0, framesCounter div 12), 100, 105, 10, DARKGRAY);
 EndDrawing();
 end;
CloseWindow();
end;

procedure Register;
var   Menu: TIDEMenuSection;
begin
  RegisterProjectDescriptor(TRaySimpleProjectDescriptor.Create);
  RegisterIDEMenuCommand(itmInfoHelps, 'AboutRayLibItem', 'About RayLib',
    nil, @ShowAbout, nil, 'menu_information');
end;

{ TRayGameSimpleProjectDescriptor }
constructor TRaySimpleProjectDescriptor.Create;
begin
  inherited Create;
  Name := 'Raylib Simple Project';
  Flags := Flags -[pfMainUnitHasCreateFormStatements,pfMainUnitHasTitleStatement] + [pfUseDefaultCompilerOptions];
end;

function TRaySimpleProjectDescriptor.GetLocalizedName: string;
begin
    Result:= 'Raylib Simple Project';
end;

function TRaySimpleProjectDescriptor.GetLocalizedDescription: string;
begin
  Result:= GetLocalizedName + LineEnding + LineEnding +
   'A simple and easy-to-use library to enjoy videogames programming (www.raylib.com)'
end;

function TRaySimpleProjectDescriptor.InitProject(AProject: TLazProject): TModalResult;
var
  Source: string;
  MainFile: TLazProjectFile;
begin
  Result := inherited InitProject(AProject);
  MainFile := AProject.CreateProjectFile('game.lpr');
  MainFile.IsPartOfProject := True;
  AProject.AddFile(MainFile, False);
  AProject.MainFileID := 0;
  Source:='program Game;' + LineEnding +
    LineEnding +
    '{$mode objfpc}{$H+}' + LineEnding +
    LineEnding +
    'uses ' +'cmem, raylib, math;' + LineEnding +  LineEnding +
    'const' +  LineEnding +
    ' screenWidth = 800;'+ LineEnding +
    ' screenHeight = 450;'+ LineEnding  + LineEnding +
    'begin' + LineEnding +
    '{$IFDEF DARWIN}' + LineEnding +
    'SetExceptionMask([exDenormalized,exInvalidOp,exOverflow,exPrecision,exUnderflow,exZeroDivide]);' + LineEnding +
    '{$IFEND}' + LineEnding + LineEnding +
    ' InitWindow(screenWidth, screenHeight, ''raylib pascal - basic window'');' + LineEnding +
    ' SetTargetFPS(60);' + LineEnding + LineEnding +
    ' while not WindowShouldClose() do ' + LineEnding +
    ' begin'+ LineEnding +
    '  BeginDrawing();' + LineEnding +
    '  ClearBackground(RAYWHITE);' + LineEnding  + LineEnding +
    '  DrawText(''raylib in lazarus !!!'', 20, 20, 20, SKYBLUE);'   + LineEnding +   LineEnding +
    '  EndDrawing(); '   + LineEnding +
    ' end;' + LineEnding +
    'CloseWindow(); ' + LineEnding +
    LineEnding +
     'end.' + LineEnding + LineEnding;
  AProject.MainFile.SetSourceText(Source);
  AProject.LazCompilerOptions.UnitOutputDirectory := 'lib' + PathDelim + '$(TargetCPU)-$(TargetOS)';
  AProject.LazCompilerOptions.TargetFilename:= 'game';
  AProject.AddPackageDependency('raylib_pas');
end;

function TRaySimpleProjectDescriptor.CreateStartFiles(AProject: TLazProject
  ): TModalResult;
begin
   Result := LazarusIDE.DoOpenEditorFile(AProject.MainFile.Filename, -1, -1,[ofProjectLoading, ofRegularFile]);
end;




end.

