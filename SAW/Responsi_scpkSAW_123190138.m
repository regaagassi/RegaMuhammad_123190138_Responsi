function varargout = Responsi_scpkSAW_123190138(varargin)
% RESPONSI_SCPKSAW_123190138 MATLAB code for Responsi_scpkSAW_123190138.fig
%      RESPONSI_SCPKSAW_123190138, by itself, creates a new RESPONSI_SCPKSAW_123190138 or raises the existing
%      singleton*.
%
%      H = RESPONSI_SCPKSAW_123190138 returns the handle to a new RESPONSI_SCPKSAW_123190138 or the handle to
%      the existing singleton*.
%
%      RESPONSI_SCPKSAW_123190138('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSI_SCPKSAW_123190138.M with the given input arguments.
%
%      RESPONSI_SCPKSAW_123190138('Property','Value',...) creates a new RESPONSI_SCPKSAW_123190138 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Responsi_scpkSAW_123190138_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Responsi_scpkSAW_123190138_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Responsi_scpkSAW_123190138

% Last Modified by GUIDE v2.5 26-Jun-2021 11:12:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Responsi_scpkSAW_123190138_OpeningFcn, ...
                   'gui_OutputFcn',  @Responsi_scpkSAW_123190138_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Responsi_scpkSAW_123190138 is made visible.
function Responsi_scpkSAW_123190138_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Responsi_scpkSAW_123190138 (see VARARGIN)

% Choose default command line output for Responsi_scpkSAW_123190138
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Responsi_scpkSAW_123190138 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Responsi_scpkSAW_123190138_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in tampil.
function tampil_Callback(hObject, eventdata, handles)
% hObject    handle to tampil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATA_RUMAH.xlsx');
opts.SelectedVariableNames = (1:7);
data = readmatrix('DATA_RUMAH.xlsx', opts);
set(handles.tabel1,'data',data,'visible','on'); %membaca file dan menampilkan pada tabel


% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
% hObject    handle to proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATA_RUMAH.xlsx');
opts.SelectedVariableNames = (2:7);
data = readmatrix('DATA_RUMAH.xlsx', opts); %membaca file
k=[0,1,1,1,1,1]; %cost atau benefit
w=[0.3,0.2,0.23,0.1,0.07,0.1]; %bobot kriteria
[m n]=size (data);
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,n); %membuat matriks Y, yang merupakan titik kosong
for j=1:n,
    if k(j)==1, %statement untuk kriteria dengan atribut benefit
        R(:,j)=data(:,j)./max(data(:,j));
    else %statement untuk kriteria dengan atribut cost
        R(:,j)=min(data(:,j))./data(:,j);
    end;
end;
for i=1:m,
    V(i)= sum(w.*R(i,:)) %proses perhitungan nilai   
end;

opts = detectImportOptions('DATA_RUMAH.xlsx');
opts.SelectedVariableNames = (1);
baru = readmatrix('DATA_RUMAH.xlsx', opts);
xlswrite('hasil_saw.xlsx', baru, 'Sheet1', 'A1'); %menulis data pada file colom A1
V=V'; %merubah data hasil perhitungan dari horizontal ke vertikal matrix
xlswrite('hasil_saw.xlsx', V, 'Sheet1', 'B1'); %menulis data pada file colom B1

opts = detectImportOptions('hasil_saw.xlsx');
opts.SelectedVariableNames = (1:2);
data = readmatrix('hasil_saw.xlsx', opts); %membaca file

X=sortrows(data,2,'descend'); %mengurutkan data dari file berdasar kolom ke-2 dari terbesar
X=X(1:20,1:2); %memilih 20 data teratas
set(handles.tabel3,'data',X,'visible','on'); %menampilkan data yang telah diurutkan ke tabel
