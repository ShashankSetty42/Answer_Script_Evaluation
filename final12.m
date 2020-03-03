function varargout = final12(varargin)
% FINAL12 MATLAB code for final12.fig
%      FINAL12, by itself, creates a new FINAL12 or raises the existing
%      singleton*.
%
%      H = FINAL12 returns the handle to a new FINAL12 or the handle to
%      the existing singleton*.
%
%      FINAL12('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINAL12.M with the given input arguments.
%
%      FINAL12('Property','Value',...) creates a new FINAL12 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before final12_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to final12_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help final12

% Last Modified by GUIDE v2.5 25-Jan-2007 21:13:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @final12_OpeningFcn, ...
                   'gui_OutputFcn',  @final12_OutputFcn, ...
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


% --- Executes just before final12 is made visible.
function final12_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to final12 (see VARARGIN)

% Choose default command line output for final12
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes final12 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = final12_OutputFcn(hObject, eventdata, handles) 
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
[filename, pathname] = uigetfile({'*.jpg';'*.bmp';'*.gif';'*.*'}, 'Pick an Image File');

S1 = imread([pathname,filename]);
% S1 =imresize(S1,[256 256]);
axes(handles.axes1);
imshow(S1);

handles.S1 = S1;
guidata(hObject, handles);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I= handles.S1;
I1=I;
I=imresize(I,[512 512]);
% figure,imshow(I)
G=rgb2gray(I);
bw=im2bw(G,0.4);
bw=~bw;
for i=1:40
    bw(:,i)=0;
end
axes(handles.axes2);
imshow(bw);
bw=~bw;
% lines_extracted = proj_prof(bw);
% for i=1:length(lines_extracted)
%     ss=lines_extracted{i,1};
%     figure,imshow(ss)
% end

ocrResults=ocr(I1);
recognizedText = ocrResults.Text;
fid=fopen('myfile1.txt','w');
fprintf(fid,[recognizedText  '\n']);
C = strsplit(recognizedText);
f=figure;
uit=uitable(f,'Data',C);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I= handles.S1;
I1=I;
% I=imresize(I,[512 512]);

ocrResults=ocr(I1);
recognizedText = ocrResults.Text;
C = strsplit(recognizedText);
C{1,1}=[];
C{1,2}=[];
for i=1:length(C)
ss=isletter(C{1,i});
if sum(ss)>=1
    C{1,i}=[];
end
end
C1=C(~cellfun('isempty',C));
find(C1{1,1}=='*');

C2=C1{1,1};
C3=eval(C2);

k=1;
k1=1;
for i=2:length(C1)
    ss=str2num(C1{1,i});
    if ss==C3
        disp(' option is');
         i1=i;    
         i2=i-1
         k=k+1;
    
    end
     
    mm(k1,:)=ss;
    k1=k1+1;
 %       
end

C5=num2str(C3);
nn=strcmp(C1,C5);
nn1=max(nn);
if nn1==1
    num='found';
end

if nn1==0
%     disp('not found');
    num='not found';
end
% str= {'Fo';'Final';'Leaf3';'Leaf4';};
% [val, num] = max(TempClassLabel);
% num1=str(num);
set(handles.edit1, 'string',num);
set(handles.edit2, 'string',C3);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
