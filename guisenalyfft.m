function varargout = guisenalyfft(varargin)
% GUISENALYFFT MATLAB code for guisenalyfft.fig
%      GUISENALYFFT, by itself, creates a new GUISENALYFFT or raises the existing
%      singleton*.
%
%      H = GUISENALYFFT returns the handle to a new GUISENALYFFT or the handle to
%      the existing singleton*.
%
%      GUISENALYFFT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUISENALYFFT.M with the given input arguments.
%
%      GUISENALYFFT('Property','Value',...) creates a new GUISENALYFFT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guisenalyfft_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guisenalyfft_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guisenalyfft

% Last Modified by GUIDE v2.5 17-Mar-2019 02:18:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guisenalyfft_OpeningFcn, ...
                   'gui_OutputFcn',  @guisenalyfft_OutputFcn, ...
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


% --- Executes just before guisenalyfft is made visible.
function guisenalyfft_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guisenalyfft (see VARARGIN)

% Choose default command line output for guisenalyfft
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
a=ones(1);
axes(handles.senal)
imshow(a)
axes(handles.tff)
imshow(a)

% UIWAIT makes guisenalyfft wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guisenalyfft_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[sig,direc]=uigetfile({'*.ogg'});
examinar=strcat(direc,sig);
[sig,fs]=audioread(examinar);
set(handles.sonido,'UserData',[sig]);
set(handles.pushbutton1,'UserData',fs);
set(handles.frecmuestreo,'String',num2str(fs));
duracionsig=length(sig)/fs;
pasosig2=1/fs:1/fs:duracionsig;
set(handles.dur,'String',num2str(duracionsig));
pasosig=fs/length(sig);
vsig=pasosig:pasosig:duracionsig;
fftsig=abs(fft(sig));
fftsigc=fftsig(1:length(sig)/2);
vsigc=vsig(1:length(vsig)/2);
frecsig=(1:length(fftsigc))*pasosig;
axes(handles.senal)
plot(pasosig2,sig),xlabel('Segundos'),ylabel('Amplitud')
axes(handles.tff)
plot(frecsig,fftsigc),xlabel('Hz'),ylabel('Amplitud')
t=find(fftsigc==max(fftsigc));
m=frecsig(t);
set(handles.fc,'String',num2str(m));
fftsigc(t)=0;
t2=find(fftsigc==max(fftsigc));
m2=frecsig(t2);
set(handles.segunda,'String',num2str(m2));


% --- Executes on button press in sonido.
function sonido_Callback(hObject, eventdata, handles)
% hObject    handle to sonido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[sig]=get(handles.sonido,'UserData');
fs=get(handles.pushbutton1,'UserData');
sound(sig,fs)
