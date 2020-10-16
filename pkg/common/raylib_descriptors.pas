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

      {TRayApplicationDescriptor }
    TRayApplicationDescriptor = class(TProjectDescriptor)
  public
    constructor Create; override;
    function GetLocalizedName: string; override;
    function GetLocalizedDescription: string; override;
    function InitProject(AProject: TLazProject): TModalResult; override;
    function CreateStartFiles(AProject: TLazProject): TModalResult; override;
  end;

    { TRayFileUnit }
    TRayFileUnit = class(TFileDescPascalUnit)
  public
    constructor Create; override;
    function GetInterfaceUsesSection: string; override;
    function GetUnitDirectives: string; override;
    function GetImplementationSource(const Filename, SourceName, ResourceName: string): string; override;
    function GetInterfaceSource(const aFilename, aSourceName, aResourceName: string): string; override;
    end;

procedure Register;

implementation
 uses raylib;

procedure ShowAbout(Sender: TObject);
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
 DrawText('contributions:', 20, 60, 10, DARKGRAY);
 DrawText(TextSubtext('Donald Duvall (tazdij)', 0, framesCounter div 9), 100, 60, 10, DARKGRAY);
 DrawText(TextSubtext('Vadim Gunko (guva)' , 0, framesCounter div 10), 100, 75, 10, DARKGRAY);
 DrawText(TextSubtext('Ludo (ludoza)' , 0, framesCounter div 11), 100, 90, 10, DARKGRAY);
 DrawText(TextSubtext('Zaher Dirkey (zaher)' , 0, framesCounter div 12), 100, 105, 10, DARKGRAY);
 EndDrawing();
 end;
CloseWindow();
end;

procedure Register;
//var   Menu: TIDEMenuSection;
begin
  RegisterProjectDescriptor(TRaySimpleProjectDescriptor.Create);
  RegisterIDEMenuCommand(itmInfoHelps, 'AboutRayLibItem', 'About RayLib',nil, @ShowAbout, nil, 'menu_information');
  RegisterProjectFileDescriptor(TRayFileUnit.Create,FileDescGroupName);
  RegisterProjectDescriptor(TRayApplicationDescriptor.Create);
end;

function FileDescriptorByName() : TProjectFileDescriptor;
begin
  Result:=ProjectFileDescriptors.FindByName('Ray Unit');
end;

{ TRayApplicationDescriptor }

constructor TRayApplicationDescriptor.Create;
begin
  inherited Create;
  Name:='RayLib Game Application';
end;

function TRayApplicationDescriptor.GetLocalizedName: string;
begin
  Result :='RayLib Game Application';
end;

function TRayApplicationDescriptor.GetLocalizedDescription: string;
begin
  Result:=GetLocalizedName + LineEnding +  LineEnding +
  'A simple and easy-to-use library to enjoy videogames programming (www.raylib.com)';
end;

function TRayApplicationDescriptor.InitProject(AProject: TLazProject
  ): TModalResult;
var
  Source: String;
  MainFile: TLazProjectFile;
begin
  Result:=inherited InitProject(AProject);
  MainFile:=AProject.CreateProjectFile('MyGame.lpr');
  MainFile.IsPartOfProject:=true;
  AProject.AddFile(MainFile,false);
  AProject.MainFileID:=0;
  AProject.UseAppBundle:=true;
//  AProject.LoadDefaultIcon;
  //Create program
  Source:='program MyGame;' + LineEnding +
    LineEnding +
    '{$mode objfpc}{$H+}' + LineEnding +
    LineEnding +
    'uses ' +'cmem, raylib, raylib_app;'              + LineEnding +  LineEnding +
    'var Game: TRayApplication;'                      + LineEnding +  LineEnding +
    ' begin'                                          + LineEnding +
    '  game:= TGame.Create;'                          + LineEnding +
    '  game.Run;'                                     + LineEnding +
    '  game.Free;'                                    + LineEnding +
    'end.'                                            + LineEnding ;

  AProject.MainFile.SetSourceText(Source);
  AProject.LazCompilerOptions.UnitOutputDirectory := 'lib' + PathDelim + '$(TargetCPU)-$(TargetOS)' + PathDelim+ 'raylib_dsgn';
  AProject.LazCompilerOptions.TargetFilename:= 'mygame';
  AProject.AddPackageDependency('raylib_pas');
  AProject.AddPackageDependency('raylib_dsgn');

end;

function TRayApplicationDescriptor.CreateStartFiles(AProject: TLazProject): TModalResult;
begin
  Result:=LazarusIDE.DoNewEditorFile(FileDescriptorByName,'','',[nfIsPartOfProject,nfOpenInEditor,nfCreateDefaultSrc]);
end;

{ TRayFileUnit }
constructor TRayFileUnit.Create;
begin
  inherited Create;
    Name:='Ray Unit';
    UseCreateFormStatements:=False;
end;

function TRayFileUnit.GetInterfaceUsesSection: string;
begin
  Result:='SysUtils,raylib,raylib_app';
end;

function TRayFileUnit.GetUnitDirectives: string;
begin
  Result:= '{$mode objfpc}{$H+} '
end;

function TRayFileUnit.GetImplementationSource(const Filename, SourceName,ResourceName: string): string;
begin
  Result:=
//  'constructor TGame.Create;'                                    +LineEnding+
//  'begin'                                                        +LineEnding+
//  ' inherited Create;'                                           +LineEnding+
//  ' InitWindow(800,600,''RayLib Game'');'                        +LineEnding+
//  'end;'                                                         +LineEnding+
                                                                  LineEnding+
  'procedure TGame.Init;'                                        +LineEnding+
  'begin'                                                        +LineEnding+
  ' InitWindow(800,600,''RayLib Game'');'                        +LineEnding+
  ' SetTargetFPS(60);'                                           +LineEnding+
  'end;'                                                         +LineEnding+
                                                                  LineEnding+
  'procedure TGame.Update;'                                      +LineEnding+
  'begin'                                                        +LineEnding+
                                                                  LineEnding+
  'end;'                                                         +LineEnding+
                                                                  LineEnding+
  'procedure TGame.Render;'                                      +LineEnding+
  'begin            '                                            +LineEnding+
  ' BeginDrawing(); '                                            +LineEnding+
  '  ClearBackground(RAYWHITE); '                                +LineEnding+
  '  DrawFPS(10,10); '                                           +LineEnding+
  ' EndDrawing(); '                                              +LineEnding+
  'end;'                                                         +LineEnding+
                                                                  LineEnding+
  'procedure TGame.Shutdown;'                                    +LineEnding+
  'begin'                                                        +LineEnding+
  ' CloseWindow();'                                               +LineEnding+
//  'inherited Shutdown;'                                          +LineEnding+
  'end;'                                               +LineEnding+LineEnding;
end;

function TRayFileUnit.GetInterfaceSource(const aFilename, aSourceName,
  aResourceName: string): string;
begin
  Result:=
  'type'                                                         +LineEnding+
  ' TGame = class(TRayApplication) '                             +LineEnding+
  '  protected'                                                  +LineEnding+
                                                                  LineEnding+
  '  public'                                                     +LineEnding+
//  '  constructor Create; override;'                              +LineEnding+
  '  procedure Init; override;'                                  +LineEnding+
  '  procedure Update; override;'                                +LineEnding+
  '  procedure Render; override;'                                +LineEnding+
  '  procedure Shutdown; override;'                              +LineEnding+
  'end;'                                            + LineEnding +LineEnding;
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
  AProject.LazCompilerOptions.UnitOutputDirectory := 'lib' + PathDelim + '$(TargetCPU)-$(TargetOS)' + PathDelim+ 'raylib_dsgn';
  AProject.LazCompilerOptions.TargetFilename:= 'game';
  AProject.AddPackageDependency('raylib_pas');
end;

function TRaySimpleProjectDescriptor.CreateStartFiles(AProject: TLazProject): TModalResult;
begin
   Result := LazarusIDE.DoOpenEditorFile(AProject.MainFile.Filename, -1, -1,[ofProjectLoading, ofRegularFile]);
end;




end.

