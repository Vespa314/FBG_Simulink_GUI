function varargout = MaskGUI(varargin)
% MASKGUI M-file for MaskGUI.fig
%      MASKGUI, by itself, creates a new MASKGUI or raises the existing
%      singleton*.
%
%      H = MASKGUI returns the handle to a new MASKGUI or the handle to
%      the existing singleton*.
%
%      MASKGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MASKGUI.M with the given input arguments.
%
%      MASKGUI('Property','Value',...) creates a new MASKGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MaskGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MaskGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MaskGUI

% Last Modified by GUIDE v2.5 06-Sep-2013 14:39:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MaskGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MaskGUI_OutputFcn, ...
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


% --- Executes just before MaskGUI is made visible.
function MaskGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MaskGUI (see VARARGIN)

% Choose default command line output for MaskGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MaskGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% neff_h = findobj('Tag','axes14')
clc;
neff_h = findobj('tag','neff_axis');
axes(neff_h);
set(neff_h,'visible','off');
text(0,0.5,'n_{neff}','fontsize',18);

delta_n_h = findobj('tag','delta_n_axis');
axes(delta_n_h);
set(delta_n_h,'visible','off');
text(0,0.5,'\Deltan','fontsize',18);

delta_n_unit_h = findobj('tag','delta_n_unit_axis');
axes(delta_n_unit_h);
set(delta_n_unit_h,'visible','off');
text(0,0.5,'×10^{-4}','fontsize',10)

dlambda_b_h = findobj('tag','lambda_b_axis');
axes(dlambda_b_h);
set(dlambda_b_h,'visible','off');
text(0,0.5,'\lambda_B','fontsize',18)


[x y] = GetMaskFunction(handles);
Mask_h = handles.Mask_axis;
axes(Mask_h);
plot(x,y,'linewidth',2);
grid on;
title('切趾形状','fontsize',24);

global annota;
annota = [];

% --- Outputs from this function are returned to the command line.
function varargout = MaskGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function neff_Callback(hObject, eventdata, handles)
% hObject    handle to neff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of neff as text
%        str2double(get(hObject,'String')) returns contents of neff as a double


% --- Executes during object creation, after setting all properties.
function neff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to neff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function delta_n_Callback(hObject, eventdata, handles)
% hObject    handle to delta_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delta_n as text
%        str2double(get(hObject,'String')) returns contents of delta_n as a double


% --- Executes during object creation, after setting all properties.
function delta_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delta_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Grate_Length_Callback(hObject, eventdata, handles)
% hObject    handle to Grate_Length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Grate_Length as text
%        str2double(get(hObject,'String')) returns contents of Grate_Length as a double


% --- Executes during object creation, after setting all properties.
function Grate_Length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Grate_Length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function chirp_Callback(hObject, eventdata, handles)
% hObject    handle to chirp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of chirp as text
%        str2double(get(hObject,'String')) returns contents of chirp as a double


% --- Executes during object creation, after setting all properties.
function chirp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chirp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function begin_lamuda_Callback(hObject, eventdata, handles)
% hObject    handle to begin_lamuda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of begin_lamuda as text
%        str2double(get(hObject,'String')) returns contents of begin_lamuda as a double


% --- Executes during object creation, after setting all properties.
function begin_lamuda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to begin_lamuda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function end_lamuda_Callback(hObject, eventdata, handles)
% hObject    handle to end_lamuda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of end_lamuda as text
%        str2double(get(hObject,'String')) returns contents of end_lamuda as a double


% --- Executes during object creation, after setting all properties.
function end_lamuda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to end_lamuda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DrawR_Button.
function DrawR_Button_Callback(hObject, eventdata, handles)
% hObject    handle to DrawR_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Draw_R(handles);


function Mask_x_axis_Callback(hObject, eventdata, handles)
% hObject    handle to Mask_x_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Mask_x_axis as text
%        str2double(get(hObject,'String')) returns contents of Mask_x_axis as a double


% --- Executes during object creation, after setting all properties.
function Mask_x_axis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mask_x_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Mask_y_axis_Callback(hObject, eventdata, handles)
% hObject    handle to Mask_y_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Mask_y_axis as text
%        str2double(get(hObject,'String')) returns contents of Mask_y_axis as a double


% --- Executes during object creation, after setting all properties.
function Mask_y_axis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mask_y_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Mask_a_Callback(hObject, eventdata, handles)
% hObject    handle to Mask_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Mask_a as text
%        str2double(get(hObject,'String')) returns contents of Mask_a as a double


% --- Executes during object creation, after setting all properties.
function Mask_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mask_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function A_slider_Callback(hObject, eventdata, handles)
% hObject    handle to A_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.Mask_a,'string',num2str(GetA(handles)));
SetMaskButton_Callback(hObject, eventdata, handles)
Draw_R(handles);

% --- Executes during object creation, after setting all properties.
function A_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function apodization_module_Callback(hObject, eventdata, handles)
% hObject    handle to apodization_module (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function gauss_module_Callback(hObject, eventdata, handles)
% hObject    handle to gauss_module (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Mask_x_axis,'string','-0.5:0.01:0.5');
set(handles.Mask_y_axis,'string','exp(-a*x.^2)');
set(handles.Mask_a,'string','20');
set(handles.A_Min,'string','0');
set(handles.A_Max,'string','40');
set(handles.A_slider,'value',0.5);
Draw_R(handles);
SetMaskButton_Callback(hObject, eventdata, handles);
% --------------------------------------------------------------------
function up_cos_module_Callback(hObject, eventdata, handles)
% hObject    handle to up_cos_module (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Mask_x_axis,'string','0:0.05:pi');
set(handles.Mask_y_axis,'string','(cos(x)+1)/2');
Draw_R(handles);
SetMaskButton_Callback(hObject, eventdata, handles);
% --------------------------------------------------------------------
function Hamming_module_Callback(hObject, eventdata, handles)
% hObject    handle to Hamming_module (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Mask_x_axis,'string','0:0.05:pi');
set(handles.Mask_y_axis,'string','(a*cos(x)+1)/(1+a)');
set(handles.Mask_a,'string','0.9');
set(handles.A_Min,'string','0');
set(handles.A_Max,'string','1.8');
set(handles.A_slider,'value',0.5);
Draw_R(handles);
SetMaskButton_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function Cauchy_module_Callback(hObject, eventdata, handles)
% hObject    handle to Cauchy_module (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Mask_x_axis,'string','-0.5:0.01:0.5');
set(handles.Mask_y_axis,'string','(1-(2*x).^2)./(1-(2*a*x).^2)');
set(handles.Mask_a,'string','0.6');
set(handles.A_Min,'string','0');
set(handles.A_Max,'string','1.2');
set(handles.A_slider,'value',0.5);
Draw_R(handles);
SetMaskButton_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function tanh_module_Callback(hObject, eventdata, handles)
% hObject    handle to tanh_module (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Mask_x_axis,'string','-0.5:0.01:0.5');
set(handles.Mask_y_axis,'string',' 1/tanh(a)*tanh(2*a*(0.5-x.*sign(x)))');
set(handles.Mask_a,'string','0.4');
set(handles.A_Min,'string','0');
set(handles.A_Max,'string','0.8');
set(handles.A_slider,'value',0.5);
Draw_R(handles);
SetMaskButton_Callback(hObject, eventdata, handles);

% --- Executes on button press in SetMaskButton.
function SetMaskButton_Callback(hObject, eventdata, handles)
% hObject    handle to SetMaskButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x y] = GetMaskFunction(handles);
Mask_h = handles.Mask_axis;
axes(Mask_h);
plot(x,y,'linewidth',2);
grid on;
title('切趾形状','fontsize',24)

function [x y] = GetMaskFunction(handles)
a_string = get(handles.Mask_a,'string');
a = eval(a_string);
x_string = get(handles.Mask_x_axis,'string');
x = eval(x_string);
y_string = get(handles.Mask_y_axis,'string');
y = eval(y_string);



function lambda_b_Callback(hObject, eventdata, handles)
% hObject    handle to lambda_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lambda_b as text
%        str2double(get(hObject,'String')) returns contents of lambda_b as a double


% --- Executes during object creation, after setting all properties.
function lambda_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lambda_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Draw_R(handles)
global annota;
begin_lambda = str2num(get(handles.begin_lamuda,'string'));
end_lambda = str2num(get(handles.end_lamuda,'string'));

lamdaRange = [begin_lambda end_lambda];
lambda = (lamdaRange(1):0.001:lamdaRange(2))* 1e-9;

lambdaB = str2double(get(handles.lambda_b,'string'))*1e-9;
n = str2double(get(handles.neff,'string'));
delta_n = str2double(get(handles.delta_n,'string'))*1e-4;
L = str2double(get(handles.Grate_Length,'string'))*1e-3;
Chirp=str2double(get(handles.chirp,'string'));

[x Mask] = GetMaskFunction(handles);
F = GetMaskMatrix(Mask,lambdaB,n,delta_n,L,lambda,Chirp);
logR = 10*log(GetR(F));
R = GetR(F);
SR = SMSR(logR);

fig = handles.axes2;
axes(fig);
[AX H1 H2]=plotyy(lambda*1e6,logR,lambda*1e6,R);

set(AX(1),'xcolor','b','ycolor','b','xlim',[lambda(1),lambda(end)]*1e6,...
   'xgrid','on','ygrid','on');
set(AX(2),'xlim',[lambda(1),lambda(end)]*1e6,'xtick',[]);
set(get(AX(1),'xlabel'),'string','Wavelength/\mum','FontSize',24) 
set(get(AX(1),'ylabel'),'string','反射率 dB','FontSize',24) 
set(get(AX(2),'ylabel'),'string','反射率','FontSize',24) 
% set(AX(1),'ylim',[-50 0]);
set(H1,'linewidth',2);
set(H2,'linewidth',2);
y_as = get(AX(1),'ylim');
% x_as = get(AX(1),'xlim');
rect = get(AX(1),'position');
rect_window = get(get(fig,'parent'),'position');
% rect(1:2) = rect(1:2)/rect_window(3);
% rect(3:4) = rect(3:4)/rect_window(4);
[maxH pos] = max(logR);
x_pos = rect(1)+pos/length(lambda)*rect(3);
y_pos = rect(2)+(maxH-y_as(1))/(y_as(2)-y_as(1))*rect(4);
y_pos2 = rect(2)+(maxH-SR-y_as(1))/(y_as(2)-y_as(1))*rect(4);

if(~isempty(annota))
    for i = 1 : length(annota)
        delete(annota(i));
    end
end
annota = [];

double_arrow1 = annotation('doublearrow',[x_pos x_pos]/rect_window(3),[y_pos y_pos2]/rect_window(4),'color','r','linewidth',2);
annota = [annota double_arrow1];
line1 = annotation('line',[x_pos-0.05*rect(3) x_pos+0.05*rect(3)]/rect_window(3),[y_pos y_pos]/rect_window(4),'linewidth',2,'color','k');
annota = [annota line1];
line2 = annotation('line',[x_pos-0.05*rect(3) x_pos+0.05*rect(3)]/rect_window(3),[y_pos2 y_pos2]/rect_window(4),'linewidth',2,'color','k');
annota = [annota line2];
text(lambda(pos)*1e6,maxH-SR/2,['\leftarrow SMSR=' sprintf('%.0f',SR) ' dB'],'FontSize',15)

% %标记带宽
if(SR>3)
    thred = 0.5;
    [pos1 pos2] = Get3dBWidth(R,thred);%3dB带宽
    bw = lambda(pos2)-lambda(pos1);
    y_as2 = get(AX(2),'ylim');
    maxH = max(R);
    x_pos1 = rect(1)+pos1/length(lambda)*rect(3);
    x_pos2 = rect(1)+pos2/length(lambda)*rect(3);
    y_pos = rect(2)+(maxH-maxH*(1-thred)-y_as2(1))/(y_as2(2)-y_as2(1))*rect(4);
    double_arrow2 = annotation('doublearrow',[x_pos1 x_pos2]/rect_window(3),[y_pos y_pos]/rect_window(4),'color','r','linewidth',2);
    annota = [annota double_arrow2];
    text(lambda(pos1)*1e6,(maxH*thred-y_as2(1)+(y_as2(2)-y_as2(1))/30)/(y_as2(2)-y_as2(1))...
        *(y_as(2)-y_as(1))+y_as(1),['3dB带宽=' num2str(bw*1e9) 'nm'],'FontSize',15,'color','k')
end

function a = GetA(handles)
min_a = str2double(get(handles.A_Min,'string'));
max_a = str2double(get(handles.A_Max,'string'));
pos = get(handles.A_slider,'value');
a = min_a + (max_a-min_a)*pos;



function A_Min_Callback(hObject, eventdata, handles)
% hObject    handle to A_Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A_Min as text
%        str2double(get(hObject,'String')) returns contents of A_Min as a double


% --- Executes during object creation, after setting all properties.
function A_Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A_Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function A_Max_Callback(hObject, eventdata, handles)
% hObject    handle to A_Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A_Max as text
%        str2double(get(hObject,'String')) returns contents of A_Max as a double


% --- Executes during object creation, after setting all properties.
function A_Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A_Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function read_mat_Callback(hObject, eventdata, handles)
% hObject    handle to read_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file path] = uigetfile('*.mat');
if ~isequal(file,0)
	data = importdata([path file]);
    data = data/max(data);
    str = '[';
    for i = 1 : length(data)
        str = [str num2str(data(i)) ' '];
    end
    str = [str ']'];
    set(handles.Mask_x_axis,'string',['linspace(-0.5,0.5,' num2str(length(data)) ')']);
    set(handles.Mask_y_axis,'string',str);
    Draw_R(handles);
    SetMaskButton_Callback(hObject, eventdata, handles);
end
