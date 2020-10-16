unit raylib_app;

{$mode objfpc}{$H+}

interface

uses raylib;

type
  { TRayApplication }
  TRayApplication = class(TObject)
  protected

  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Init;virtual;
    procedure Shutdown; virtual;
    procedure Update; virtual;
    procedure Render; virtual;
    procedure Run;
  end;

implementation

{ TRayApplication }
constructor TRayApplication.Create;
begin
 inherited Create;
end;

destructor TRayApplication.Destroy;
begin
  inherited Destroy;
end;

procedure TRayApplication.Init;
begin

end;

procedure TRayApplication.Shutdown;
begin

end;

procedure TRayApplication.Update;
begin

end;

procedure TRayApplication.Render;
begin
end;

procedure TRayApplication.Run;
begin
  Init;
  // Enter the main loop
  while not WindowShouldClose() do
  begin
    Update;
    Render;
  end;
  Shutdown;
end;

end.

