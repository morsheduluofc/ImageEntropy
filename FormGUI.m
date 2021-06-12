function varargout = FormGUI(varargin)
% FORMGUI MATLAB code for FormGUI.fig
%      FORMGUI, by itself, creates a new FORMGUI or raises the existing
%      singleton*.
%
%      H = FORMGUI returns the handle to a new FORMGUI or the handle to
%      the existing singleton*.
%
%      FORMGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FORMGUI.M with the given input arguments.
%
%      FORMGUI('Property','Value',...) creates a new FORMGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FormGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FormGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FormGUI

% Last Modified by GUIDE v2.5 09-Jul-2018 15:47:41

% Begin initialization code - DO NOT EDIT
%global image;
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FormGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FormGUI_OutputFcn, ...
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


% --- Executes just before FormGUI is made visible.
function FormGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FormGUI (see VARARGIN)

% Choose default command line output for FormGUI
handles.output = hObject;
handles.imageChoose=0;
handles.exitbutton=0;
handles.processStart=0;
%axes(handles.axes2);
%imshow('steps.png');
ax=handles.axes2;
t=text(0.3, 0.9, 'Follow the Steps', 'Parent', ax);
t.FontWeight='bold';
text(0.03, 0.7, 'Step 1: Choose an image/image folder', 'Parent', ax);
text(0.03, 0.6, 'Step 2 (Opt): Choose a gscale averaging table', 'Parent', ax);
text(0.03, 0.5, 'Step 3 (Opt): Choose a zone mapped table', 'Parent', ax);
text(0.03, 0.4, 'Step 4: Input metering area and scaling factor', 'Parent', ax);
text(0.03, 0.3, 'Step 5: Press Start Process button', 'Parent', ax);
text(0.03, 0.2, '*End Process button to terminate a process', 'Parent', ax);
text(0.03, 0.1, '*Exit button to close the program', 'Parent', ax);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FormGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FormGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%ax1=axes('Units','pix','Position',[20 40 500 20]);
%set(ax1,'Xtick',[],'Ytick',[],'Xlim',[0 1000]);
%box on;
%ax2=axes('Units','pix','Position',[20 80 500 20]);
%set(ax2,'Xtick',[],'Ytick',[],'Xlim',[0 1000]);
%box on;

function textbox1_Callback(hObject, eventdata, handles)
% hObject    handle to textbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textbox1 as text
%        str2double(get(hObject,'String')) returns contents of textbox1 as a double


% --- Executes during object creation, after setting all properties.
function textbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textbox2_Callback(hObject, eventdata, handles)
% hObject    handle to textbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textbox2 as text
%        str2double(get(hObject,'String')) returns contents of textbox2 as a double


% --- Executes during object creation, after setting all properties.
function textbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textbox3_Callback(hObject, eventdata, handles)
% hObject    handle to textbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textbox3 as text
%        str2double(get(hObject,'String')) returns contents of textbox3 as a double


% --- Executes during object creation, after setting all properties.
function textbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%{
% --- Executes on button press in sumbutton.
function sumbutton_Callback(hObject, eventdata, handles)
% hObject    handle to sumbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a1=str2num(get(handles.textbox1,'String'));
a2=str2num(get(handles.textbox2,'String'));
a=a1+a2;
set(handles.textbox3,'String',a);
%mainFunction(image);
%XBar=0.3;
%h=waitbar(XBar,'Processing....');

%}


% --- Executes on button press in chooseImgbutton.
function chooseImgbutton_Callback(hObject, eventdata, handles)
% hObject    handle to chooseImgbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[imgFileName,imgPathName] = uigetfile({'*.png';'*.jpg';'*.jpeg';'*.gif*'},'Select an image');
%image=imread(strcat(imgPathName,imgFileName));
if(imgFileName ~=0)
    rawImgData=imread(strcat(imgPathName,imgFileName));
    %rawImgData=strcat(imgPathName,imgFileName);
    %axes(handles.imagePad)
    %disp(imgPathName);
    axes(handles.axes2)
    %text(handles.text9)
    imshow(rawImgData)
    handles.imgFileName=imgFileName;
    handles.imgPathName=imgFileName;
    handles.imgPathName=imgPathName;
    handles.rawImgData=rawImgData;
    handles.imageChoose=1;
    handles.linearAveragingDataFile=0;
    handles.zTableDataFile=0;
    handles.FileFolder=0;
    handles.exitbutton=0;
    guidata(hObject,handles)
    
    set(handles.textbox1,'String','');
    set(handles.textbox2,'String','');
    set(handles.textbox3,'String','');
    set(handles.text9, 'String', num2str(0.0));
    set(handles.text10, 'String', num2str(0.0));
    set(handles.text11, 'String', num2str(0.0));

else
    return;
end


% --- Executes on button press in processbutton.
function processbutton_Callback(hObject, eventdata, handles)
% hObject    handle to processbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if (isempty(get(handles.textbox1,'String')) || isempty(get(handles.textbox2,'String'))|| (handles.imageChoose==0))
f = errordlg('Choose an Image, choose all tables(optional) and then input data..','Input Error');
%f = errordlg(strcat(get(handles.textbox1,'String'),get(handles.textbox2,'String'),num2str(handles.imageChoose)),'Input Error');
return
end
set(handles.processbutton,'string','Process Running','enable','off');
set(handles.pushbutton6,'enable','on');
set(handles.chooseImgbutton,'enable','off');
set(handles.pushbutton4,'enable','off');
set(handles.pushbutton5,'enable','off');
set(handles.imgFolder,'enable','off');
%Measure diamter of spot meter circle
%inputMetArea=2.0;
%metScalFactor=2.0;
%sCircleDiameter=ASquareCal(inputMetArea,metScalFactor,grayScaleImgH,grayScaleImgW);
if(handles.FileFolder==0)
if(size(handles.rawImgData,3)==3)    
grayScaleImgData = rgb2gray(handles.rawImgData);
else
 grayScaleImgData = handles.rawImgData;
end
[grayScaleImgW,grayScaleImgH]=size(grayScaleImgData);
handles.grayScaleImgW=grayScaleImgW;
handles.grayScaleImgH=grayScaleImgH;
inputMetArea=str2num(get(handles.textbox1,'String'));
metScalFactor=str2num(get(handles.textbox2,'String'));
handles.inputMetArea=inputMetArea;
handles.metScalFactor=metScalFactor;
sCircleDiameter=sCircleDiameterF(inputMetArea,metScalFactor,grayScaleImgH,grayScaleImgW);
%a=a1+a2;
set(handles.textbox3,'String',sCircleDiameter);
mainFunction1(grayScaleImgData,handles.rawImgData,handles.imgPathName,handles.imgFileName,sCircleDiameter, handles);
end
handles.fileNo=1;
handles.exitbutton= 0;
guidata(hObject,handles);

if(handles.FileFolder==1)
for fileNo=1:handles.noOfFileinAFolder
imgFileName=handles.MyFolderInfo(fileNo+2).name;
[filepath,name,ext] = fileparts(imgFileName); 
x = strmatch(ext, char('.png','.jpeg','.jpg'));
if (x==1)
rawImgData=imread(strcat(handles.imgPathName,'\',imgFileName));
handles.imgFileName=imgFileName;
%axes(handles.axes2)
%text(handles.text9)
%imshow(rawImgData)
if(size(rawImgData,3)==3)    
grayScaleImgData = rgb2gray(rawImgData);
else
 grayScaleImgData = rawImgData;
end  
handles.rawImgData=rawImgData;
[grayScaleImgW,grayScaleImgH]=size(grayScaleImgData);
handles.grayScaleImgW=grayScaleImgW;
handles.grayScaleImgH=grayScaleImgH;
inputMetArea=str2num(get(handles.textbox1,'String'));
metScalFactor=str2num(get(handles.textbox2,'String'));
handles.inputMetArea=inputMetArea;
handles.metScalFactor=metScalFactor;
sCircleDiameter=sCircleDiameterF(inputMetArea,metScalFactor,grayScaleImgH,grayScaleImgW);
set(handles.textbox3,'String',sCircleDiameter); 
mainFunction1(grayScaleImgData,handles.rawImgData,handles.imgPathName,imgFileName,sCircleDiameter,handles);
end
end
end
%uiwait(msgbox('Operation Completed........'));
set(handles.processbutton,'string','Start Process','enable','on');
set(handles.pushbutton6,'enable','off');
set(handles.chooseImgbutton,'enable','on');
set(handles.pushbutton4,'enable','on');
set(handles.pushbutton5,'enable','on');
set(handles.imgFolder,'enable','on');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[linAveragingFileName,linAveragingTable] = uigetfile({'*.csv'},'Select a *.csv file.');
%image=imread(strcat(linAveragingTable,imgFileName));
if(linAveragingFileName ~=0)
    linearAveragingDataFile=csvread(strcat(linAveragingTable,linAveragingFileName),1,0);
    handles.linearAveragingDataFile=linearAveragingDataFile;
    %image=strcat(linAveragingTable,imgFileName);
    %axes(handles.imagePad)     
else
    return;
end
    

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[zTableFileName,zoneTable] = uigetfile({'*.csv'},'Select a *.csv file.');
%image=imread(strcat(zoneTable,imgFileName));
if(zTableFileName ~=0)
    zTableDataFile=csvread(strcat(zoneTable,zTableFileName),1,0);
    handles.zTableDataFile=zTableDataFile;
    %image=strcat(zoneTable,imgFileName);
    %axes(handles.imagePad)     
else
    return;
end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

answer = questdlg('Do you like to end the process?','','Yes','No','');
% Handle response
switch answer
    case 'Yes'
    set(handles.chooseImgbutton,'enable','on');
    set(handles.pushbutton4,'enable','on');
    set(handles.pushbutton5,'enable','on');
    set(handles.imgFolder,'enable','on');    
    set(handles.processbutton,'string','Start Process','enable','on');
    set(handles.pushbutton6,'enable','off');
    set(handles.textbox1,'String','');
    set(handles.textbox2,'String','');
    set(handles.textbox3,'String','');
    cla (handles.axes2,'reset');
    %cla
    ax=handles.axes2;
    set(ax,'box','on','XTick',[],'YTick',[]);
    %set(ax,'XTick',[]);
    t=text(0.3, 0.9, 'Follow the Steps', 'Parent', ax);
    t.FontWeight='bold';
    text(0.03, 0.7, 'Step 1: Choose an image/image folder', 'Parent', ax);
    text(0.03, 0.6, 'Step 2 (Opt): Choose a gscale averaging table', 'Parent', ax);
    text(0.03, 0.5, 'Step 3 (Opt): Choose a zone mapped table', 'Parent', ax);
    text(0.03, 0.4, 'Step 4: Input metering area and scaling factor', 'Parent', ax);
    text(0.03, 0.3, 'Step 5: Press Start Process button', 'Parent', ax);
    text(0.03, 0.2, '*End Process button to terminate a process', 'Parent', ax);
    text(0.03, 0.1, '*Exit button to close the program', 'Parent', ax);
   set(handles.text9, 'String', num2str(0.0));
   set(handles.text10, 'String', num2str(0.0));
   set(handles.text11, 'String', num2str(0.0));
   axes(handles.axes3)
   cla
   %rectangle('Position',[0,0,1001-(round(1000*i/k)),20],'FaceColor','b');
   %text(420,10,['Remaining:',num2str(100-round(100*i/k)),'%']);
   axes(handles.axes4)
   cla
   %rectangle('Position',[0,0,(round(1000*i/k))+1,20],'FaceColor','r'); 
   %text(420,10,['Finished:',num2str(round(100*i/k)),'%']);
   %pause(0.11)
    uiwait(gcf);
    case 'No'  
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%function close_Callback(hObject, eventdata, handles)

%clearStr='clear all';
%evalin('base',clearStr);
%delete(handles.figure1);
answer = questdlg('Exit the program?','','Yes','No','');
% Handle response
switch answer
    case 'Yes'
    exit();
   case 'No'  
end

% --- Executes on button press in imgFolder.
function imgFolder_Callback(hObject, eventdata, handles)
% hObject    handle to imgFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imgPathName = uigetdir();
if(imgPathName ~=0)
MyFolderInfo = dir(imgPathName);
noOfFileinAFolder=size(MyFolderInfo);
noOfFileinAFolder=noOfFileinAFolder-2;
if (noOfFileinAFolder<=0)
errordlg('No image file in this folder.','Input Error');
%f = errordlg(strcat(get(handles.textbox1,'String'),get(handles.textbox2,'String'),num2str(handles.imageChoose)),'Input Error');
return
else

 axes(handles.axes2)
 %text(handles.text9)
 imshow('folderImg.png')
 handles.imgPathName=imgPathName;
 handles.MyFolderInfo=MyFolderInfo;
 %handles.rawImgData=rawImgData;
 handles.imageChoose=1;
 handles.linearAveragingDataFile=0;
 handles.zTableDataFile=0;
 handles.FileFolder=1;
 handles.noOfFileinAFolder= noOfFileinAFolder;
 guidata(hObject,handles)
    
 set(handles.textbox1,'String','');
 set(handles.textbox2,'String','');
 set(handles.textbox3,'String','');
 set(handles.text9, 'String', num2str(0.0));
 set(handles.text10, 'String', num2str(0.0));
 set(handles.text11, 'String', num2str(0.0));
end
else
    return
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
