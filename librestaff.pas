program librestaff;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Classes, DataModule, DefaultTranslator, Controls, sqldb,
  FormLogin, FormPrgBar, FormMain, FuncData, SysUtils, INIfiles,
  Globals;

{$R *.res}

var
  LoginOK: Integer;
  Login: TFrmLogin;

procedure CreateMainForm;
	begin
  Screen.Cursor:= crHourglass;
	//The progress bar to show the database load:
	FrmPrgBar:= TFrmPrgBar.Create(Application);
	FrmPrgBar.ShowOnTop;
	Application.CreateForm(TFrmMain, FrmMain);
	Application.Run;
  end;

begin
  RequireDerivedFormResource:= True;
  Application.Title:= 'LibreStaff';
	Application.Initialize;
  Application.CreateForm(TDataMod, DataMod);
  PathApp:= ExtractFilePath(Paramstr(0));
  SQLiteLibraryName:= PathApp+'sqlite3.dll';
  //INI File Section:
  INIFile:= TINIFile.Create(PathApp+'config.ini', True);
	if not FileExists(PathApp+'config.ini') then
		INIFile.WriteString('Database', 'Path', '"'+PathApp+'data\"');
  //Set some paths
  DatabasePath:= INIFile.ReadString('Database', 'Path', PathApp+'data\');
  DatabaseName:= DatabasePath + 'data.db';
  //Connect & Load to database
  FuncData.ConnectDatabase(Databasename);
  FuncData.ExecSQL(DataMod.QueConfig, 'SELECT * from Config LIMIT 1;');
  AccessControl:= DataMod.QueConfig.FieldByName('AccessControl').AsBoolean;
  if (AccessControl= TRUE) then
  	begin
    FuncData.ExecSQL(DataMod.QueUsers, SELECT_ALL_USERS_SQL); //Open User's table
	  Login:= TFrmLogin.Create(nil); //Create Login Form not owned by object
  	LoginOK:= Login.ShowModal;
	  if (LoginOK= mrOK) then
  		begin
      CreateMainForm;
    	end;
		Login.Free; //Free the login form
    end
  else
  	begin
    CreateMainForm;
    end;
end.
