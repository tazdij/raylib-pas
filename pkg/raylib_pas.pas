{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit raylib_pas;

{$warn 5023 off : no warning about unused units}
interface

uses
  raylib, raymath, rlgl, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('raylib_pas', @Register);
end.
