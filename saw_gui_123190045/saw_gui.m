function varargout = saw_gui(varargin)
% SAW_GUI MATLAB code for saw_gui.fig
%      SAW_GUI, by itself, creates a new SAW_GUI or raises the existing
%      singleton*.
%
%      H = SAW_GUI returns the handle to a new SAW_GUI or the handle to
%      the existing singleton*.
%
%      SAW_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAW_GUI.M with the given input arguments.
%
%      SAW_GUI('Property','Value',...) creates a new SAW_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before saw_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to saw_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help saw_gui

% Last Modified by GUIDE v2.5 26-Jun-2021 07:48:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @saw_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @saw_gui_OutputFcn, ...
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


% --- Executes just before saw_gui is made visible.
function saw_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to saw_gui (see VARARGIN)

% Choose default command line output for saw_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes saw_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = saw_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnShow.
function btnShow_Callback(hObject, eventdata, handles)
% hObject    handle to btnShow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

opts = detectImportOptions('DATA RUMAH.xlsx'); 
opts.SelectedVariableNames = (3:8);
data = readmatrix('DATA RUMAH.xlsx',opts);
set(handles.uitable1, 'data', data); % menampilakan seluruh data 


% --- Executes on button press in btnProc.
function btnProc_Callback(hObject, eventdata, handles)
% hObject    handle to btnProc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = (3:8);
data = readmatrix('DATA RUMAH.xlsx',opts); % mengambil data dari file excel mulai dari kolom 3 sampai 8

opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = (1);
rek = readmatrix('DATA RUMAH.xlsx',opts); % mengambil data nama rumah dari file excel

opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = (3);
rek_harga = readmatrix('DATA RUMAH.xlsx',opts);% mengambil data harga rumah dari file excel

k = [0 1 1 1 1 1]; % attribut tiap kriteria, 0 untuk cost dan 1 untuk benefit
w = [30/100 20/100 23/100 10/100 7/100 10/100]; % bobot untuk setiap kategori
[index_rekomendasi, data_V] = HitungSAW(data, k, w); % memanggil fungsi perhitungan SAW
data_V_t = transpose(data_V);

set(handles.uitable2,'data', [rek(index_rekomendasi) data_V_t rek_harga(index_rekomendasi)]); 
% menampilkan hasil rekomendasi berdasarkan index rekomendasi yang sudah di
% cari pada fungsi diatas


% --- Executes when entered data in editable cell(s) in uitable2.
function uitable2_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
