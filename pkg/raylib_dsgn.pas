{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit raylib_dsgn;

{$warn 5023 off : no warning about unused units}
interface

uses
  raylib_descriptors, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('raylib_descriptors', @raylib_descriptors.Register);
end;

initialization
  RegisterPackage('raylib_dsgn', @Register);
end.
