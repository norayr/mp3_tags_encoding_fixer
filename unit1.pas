unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls, id3;

type

  { TForm1 }

  TForm1 = class(TForm)
    bTitle: TButton;
    cGenre: TComboBox;
    eArtist: TEdit;
    eAlbum: TEdit;
    eComment: TEdit;
    eYear: TEdit;
    eTag: TEdit;
    eTitle: TEdit;
    lGenre: TLabel;
    lComment: TLabel;
    lYear: TLabel;
    lAlbum: TLabel;
    lArtist: TLabel;
    lTag: TLabel;
    lTitle: TLabel;
    MainMenu1: TMainMenu;
    mSave: TMenuItem;
    mOpen: TMenuItem;
    mFile: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure bTitleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mOpenClick(Sender: TObject);
    procedure showTags(t : id3.TID3Tag);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

var
    tags : id3.TID3Tag;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
    cGenre.Items.AddStrings(id3.Genres);
end;

procedure TForm1.bTitleClick(Sender: TObject);
var
    fs : TFileStream;
begin
  if SaveDialog1.Execute then
  begin
    fs := TFileStream.Create(SaveDialog1.FileName, fmOpenReadWrite or fmCreate);
    fs.WriteAnsiString(eArtist.Text);
  end;
end;

procedure TForm1.showTags(t : id3.TID3Tag);
begin
  eTag.Text := t.ID;
  eTitle.Text:= t.Title;
  eArtist.Text:= t.Artist;
  eAlbum.Text:= t.Album;
  eYear.Text:= t.Year;
  eComment.Text:= t.Comment;
  cGenre.ItemIndex:= t.Genre;
end;

procedure TForm1.mOpenClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'MP3 files (*.mp3)|*.mp3';
  if OpenDialog1.Execute then
  begin
    tags := id3.readID3Tag(OpenDialog1.FileName);
    showTags(tags);
  end;
end;

end.

