function varargout = Test(varargin)
% TEST MATLAB code for Test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Test

% Last Modified by GUIDE v2.5 05-Jan-2017 14:45:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Test_OpeningFcn, ...
                   'gui_OutputFcn',  @Test_OutputFcn, ...
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
% global PointECC signal a b module basepointx basepointy


% --- Executes just before Test is made visible.
function Test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Test (see VARARGIN)

% Choose default command line output for Test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%HIEN THI LOGO
axes(handles.logo);
imshow('elliptic2.png');

% LAY CAC GIA TRI A,B, FIELD TU GIAO DIEN XUONG
a =  str2double(get(handles.eb_factora, 'string'));
b =  str2double(get(handles.eb_factorb, 'string'));
p =  str2double(get(handles.eb_module_finite, 'string'));
%HIEN THI DO THI TREN AXES
axes(handles.smallgraph);
hold on;
[x,y] = meshgrid(linspace(-5,5,550));
contour(x,y,y.^2 - (x.^3 + a*x + b),'LevelList',0, 'LineWidth', 2.3, 'color', 'm');
grid on;
% TINH TAT CA CAC DIEM NAM TRONG TRUONG GIOI HAN "MODULE"
[points,numberPoints] = compute_AllPointsFinite(p, a, b);
% CAP NHAT P(X,Y) VA Q(X,Y) TRONG "FINITE"
for i = 1:numberPoints
    % CAP NHAT P
    px{i}= num2str(points(i,1));
    set(handles.popup_px_finite, 'String', px);
    py{i}= num2str(points(i,2));
    set(handles.popup_py_finite, 'String', py);
    % CAP NHAT Q
    qx{i}= num2str(points(i,1));
    set(handles.popup_qx_finite, 'String', qx);
    qy{i}= num2str(points(i,2));
    set(handles.popup_qy_finite, 'String', qy);
end
guidata(hObject,handles);


% --- Outputs from this function are returned to the command line.
function varargout = Test_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% -------------------- GLOBAL VARIABLE --------------------
function set_signal(val)
global signal
signal = val;

function sig = get_signal
global signal
sig = signal;

function set_flag(val)
global f
f = val;

function flag = get_flag
global f
flag = f;

function set_GroupPointsFinite(val)
global groupPoints
groupPoints = val;



% -------------------- FUNTION --------------------
% LAY CAC GIA TRI TU a, b, P, Q, n, module TU GIAO DIEN - DANG "FINITE"
function [a,b,mod,px,py,qx,qy,n] = getValueFromGUI_finite(factora, factorb, module, Px, Py, Qx, Qy, N)
% LAY CHUOI TU "EDITTEXT" A XUONG
str_a = get(factora, 'String');
% LAY CHUOI TU "EDITTEXT" B XUONG
str_b = get(factorb, 'String');
% LAY CHUOI TU "EDITTEXT" MODULE XUONG
str_module = get(module, 'String');
% LAY CHUOI TU "POPUP" PX XUONG
str = get(Px, 'String');
index = get(Px,'Value');
item_px = str{index};
% LAY CHUOI TU "POPUP" PX XUONG
str = get(Py, 'String');
index = get(Py,'Value');
item_py = str{index};
% LAY CHUOI TU "POPUP" PX XUONG
str = get(Qx, 'String');
index = get(Qx,'Value');
item_qx = str{index};
% LAY CHUOI TU "POPUP" PX XUONG
str = get(Qy, 'String');
index = get(Qy,'Value');
item_qy = str{index};
% LAY CHUOI TU "EDITTEXT" N XUONG
str_n = get(N, 'String');

a = str2double(str_a);
b = str2double(str_b);
mod = str2double(str_module); % setGlobal_module(module);
px = str2double(item_px);
py = str2double(item_py);
qx = str2double(item_qx);
qy = str2double(item_qy);
n = str2double(str_n);

% LAY CAC GIA TRI TU a, b, P, Q, n, module TU GIAO DIEN - DANG "INFINITE"
function [a,b,px,py,qx,qy,n] = getValueFromGUI_infinite(factora, factorb, Px, Py, Qx, Qy, N)
str_a = get(factora, 'String');
str_b = get(factorb, 'String');
str_px = get(Px, 'String');
str_py = get(Py, 'String');
str_qx = get(Qx, 'String');
str_qy = get(Qy, 'String');
str_n = get(N, 'String');

a = str2double(str_a);
b = str2double(str_b);
px = str2double(str_px);
py = str2double(str_py);
qx = str2double(str_qx);
qy = str2double(str_qy);
n = str2double(str_n);

% KIEM TRA isEMPTY
if isempty(a) || isempty(b) || isempty(px) || isempty(py) || isempty(qx) || isempty(qy) || isempty(n) || isnan(a) || isnan(b) || isnan(px) || isnan(py) || isnan(qx) || isnan(qy) || isnan(n)
    str = 'There is a data cell is empty or not a number';
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox(str, 'Invalid', 'error', CreateStruct);
    set_flag(false);
    return;
end

% THIET LAP LAI TUA DE
function [signal1, signal2] = set_Title(a, b, sig1, sig2, labela, labelb)
if  a < 0
    set(sig1, 'String', '-');
    signal1 = '-';
else
    set(sig1, 'String', '+');
    signal1 = '+';
end
if  b < 0
    set(sig2, 'String', '-');
    signal2 = '-';
else
    set(sig2, 'String', '+');
    signal2 = '+';
end
set(labela, 'String', num2str(abs(a)));
set(labelb, 'String', num2str(abs(b)));

% KIEM TRA SO NGUYEN TO
function Prime = isPrime(val)
if val < 2
   Prime = false;
   return; 
end
for i = 2:sqrt(val)
    if mod(val, i) == 0
       Prime = false;
       return;
    end
end
Prime = true;

% KIEM TRA DIEM CO THUOC DO THI - D?NG "INFINITE"
function belong = infinite_belongGraph(x, y, factorA, factorB)
left_side = y;
right_side = sqrt(x.^3 + factorA*x + factorB);
Ndecimals = 4;
f = 10.^Ndecimals; 
right_side = round(f*right_side)/f;
left_side = round(f*left_side)/f;
% right_side = sqrt(x.^3 + factorA*x + factorB);
if left_side == right_side
    belong = true;
    return;
end
belong = false;

% KIEM TRA DIEM CO THUOC DO THI - D?NG "FINITE"
function belong = finite_belongGraph(x, y, factorA, factorB, module)
left_side = mod(y.^2, module);
right_side = mod(x.^3 + factorA*x + factorB, module);
if left_side == right_side
    belong = true;
    return;
end
belong = false;

% DIEU KIEN THOA MAN CUA HAI HE SO A VA B
function cond = condition_AB(factorA, factorB)
if (4*(factorA.^3) + 27*(factorB.^2)) == 0
   cond = false;
   return;
end
cond = true;

% CACH TINH "MOD" DOI VOI PHAN SO
function module_denominator = module_denominator(denominator, module)
module_denominator = 0;
for i = 1:module
   for j = 1:(denominator*i)
      if (((denominator*i)-(module*j))==1)
          module_denominator = i;
          return;
      end
   end
end

% R = P + Q - DANG "INFINITE"
function PQ = P_add_Q_infinite(xp, yp, xq, yq)
if (xq - xp) == 0
    set_signal(true);
    PQ = [inf,inf];
    return;
end
s = (yq - yp)/(xq - xp);
x = s.^2 - xp - xq;
y = s*(xp - x) - yp;
PQ = [x,y];

% R = P + Q - DANG "FINITE"
function PQ = P_add_Q_finite(xp, yp, xq, yq, module)
s_tu = yp - yq;
if s_tu > module
    s_tu = mod(s_tu, module);    
end
s_mau = xp - xq;
if s_mau == 0
    set_signal(true);
    PQ = [inf,inf];
    return;
end
if abs(s_mau) ~= 1
    if (s_mau < 0)
        s_mau = - module_denominator(abs(s_mau), module);
    else
        s_mau = module_denominator(abs(s_mau), module);
    end
end
s = (s_tu * s_mau);
x = mod((s*s - (xp + xq)), module);
if x < 0
   x = module + x; 
end
y = mod((s * (xp - x) - yp), module);
if y < 0
   y = module + y; 
end
PQ = [x,y];

% R = 2P - DANG "INFINITE"
function PD = PointDouble_infinite(xp, yp, factorA)
if (2*yp) == 0
    set_signal(true);
    PD = [inf,inf];
    return;
end
s = (3*xp*xp + factorA)/(2*yp);
x = s.^2 - 2*xp;
y = s*(xp - x) - yp;
PD = [x,y];

% R = 2P - DANG "FINITE"
function PD = PointDouble_finite(xg,yg, module, factorA)
s_tu = 3*xg*xg + factorA;
if s_tu > module
   s_tu = mod(s_tu, module); 
end
s_mau = 2*yg;
if s_mau == 0
   set_signal(true);
   PD = [inf,inf];
   return;
end
if abs(s_mau) ~= 1
   if s_mau < 0
       s_mau = - module_denominator(abs(s_mau), module);
   else
      s_mau = module_denominator(abs(s_mau), module); 
   end
end
s = (s_tu * s_mau);
if s > module
    s = mod(s, module);
end
x = mod((s * s - 2 * xg), module);
if x < 0
   x = module + x; 
end
y = mod((s * (xg - x) - yg), module);
if y < 0
   y = module + y; 
end
PD = [x,y];


% TAT CA CAC DIEM DUOC TINH LUU TRONG "setGlobal_Points(Points)"
% - DANG "FINITE"
function [points,numberPoints] = compute_AllPointsFinite(module, factorA, factorB)
finite = 0:(module-1);
left_side = mod(finite.^2, module);
right_side = mod(finite.^3 + factorA*finite + factorB, module);
points = [];
for i = 1:length(right_side)
    I = find(left_side == right_side(i));
    for j = 1:length(I)
        points = [points; finite(i), finite(I(j))];
    end
end
points = [points; inf, inf];
numberPoints = length(points);

% NHOM CAC DIEM DUOC TINH LUU TRONG "setGlobal_GroupPoints(Points)"
% - DANG "FINITE"
function Points = subgroup_finite(basepointx, basepointy, module, factorA)
Points = [basepointx, basepointy];
temp = PointDouble_finite(basepointx, basepointy, module, factorA);
Points = vertcat(Points,temp);
while true
   temp = P_add_Q_finite(temp(:,1), temp(:,2), basepointx, basepointy, module);
   Points = vertcat(Points, temp);
   if get_signal
       set_signal(false); %NEU TOA DO LA "INFINITE" THI DUNG
       set_GroupPointsFinite(Points);
       return;
   end
end

% VE DO THI - DANG "FINITE"
function drawFinite(points, module)
plot(points(:,1), points(:,2), 'bo');
set(gca, 'XTick', 0:10:(module-1));
set(gca, 'YTick', 0:10:(module-1));
grid on;

% TINH TOAN BO CAC DIEM TREN TRUONG "FINITE" VA GOI HAM "drawFinite"
function simulation_Finite(module, factorA, factorB)
[points, ~] = compute_AllPointsFinite(module, factorA, factorB);
% figure(1);
drawFinite(points, module);


% --- Executes on button press in btn_grouporder_finite.
function btn_grouporder_finite_Callback(hObject, eventdata, handles)
% LAY GIA TRI TU GIAO DIEN XUONG
[a,b,module,px,py,~,~,~] = getValueFromGUI_finite(handles.eb_factora, handles.eb_factorb, handles.eb_module_finite, handles.popup_px_finite, handles.popup_py_finite, handles.popup_qx_finite, handles.popup_qy_finite, handles.eb_n_finite);
% KIEM TRA 4A^3 + 27B^2 CO = 0 ?
if ~condition_AB(a, b)
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox('4A^3 + 27B^2  is nonzero', 'Error', 'error', CreateStruct);
    return;
end
% THIET LAP LAI TUA DE Y^2 = X^3 + AX + B
set_Title(a, b, handles.lb_sign1, handles.lb_sign2, handles.lb_factorA, handles.lb_factorB);
% KIEM TRA MODULE CO PHAI LA SO NGUYEN TO
if ~isPrime(module)
    text = ['Module = [', num2str(module), ']', char(10), num2str(module), ' is not prime!'];
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox(text, 'Invalid', 'error', CreateStruct);
    return;    
end
% TINH TAT CA CAC DIEM NAM TRONG TRUONG GIOI HAN "MODULE"
[points,numberPoints] = compute_AllPointsFinite(module, a, b);
% CAP NHAT P(X,Y) VA Q(X,Y) TRONG "FINITE"
for i = 1:numberPoints
    % CAP NHAT P
    xp{i}= num2str(points(i,1));
    set(handles.popup_px_finite, 'String', xp);
    yp{i}= num2str(points(i,2));
    set(handles.popup_py_finite, 'String', yp);
    % CAP NHAT Q
    xq{i}= num2str(points(i,1));
    set(handles.popup_qx_finite, 'String', xq);
    yq{i}= num2str(points(i,2));
    set(handles.popup_qy_finite, 'String', yq);
end
% LIET KE CAC DIEM (SUB POINTS) VAO LISTBOX
set(handles.lb_grouporder_finite, 'string', []);
Points = subgroup_finite(px, py, module, a);
len = length(Points);
for i = 1 : len
   text = [num2str(i), 'G = (', num2str(Points(i,1)), ', ', num2str(Points(i,2)), ')'];
   old_str = get(handles.lb_grouporder_finite, 'string');
   new_str = strvcat(old_str, text);
   set(handles.lb_grouporder_finite, 'string', new_str);
end
% HIEN THI SO LUONG DIEM TRONG TRUONG GIOI HAN "MODULE"
set(handles.txt_curvehas_finite, 'string', ['Curve has ', num2str(numberPoints), ' points', char(10), '(including the point at infinity)']);
set(handles.txt_subgroup_finite, 'string', ['The subgroup generated by P has ', num2str(len), ' points']);
% MO PHONG TOAN BO DIEM DO TREN DO THI
clf(figure(1));
figure(1);
hold on;
simulation_Finite(module, a, b);
plot(Points(:,1), Points(:,2), 'gs', 'MarkerFaceColor','r');


% --- Executes on button press in btn_pq_infinite.
function btn_pq_infinite_Callback(hObject, eventdata, handles)
% LAY CAC GIA TRI TU GIAO DIEN XUONG
set_flag(true);
[a,b,px,py,qx,qy,~] = getValueFromGUI_infinite(handles.eb_factora, handles.eb_factorb, handles.eb_px_infinite, handles.eb_py_infinite, handles.eb_qx_infinite, handles.eb_qy_infinite, handles.eb_n_infinite);
if ~get_flag
   set(handles.eb_pqx_infinite, 'string', []);
   set(handles.eb_pqy_infinite, 'string', []);
   return; 
end
% KIEM TRA 4A^3 + 27B^2 == 0 ? TRUE : FALSE
if ~condition_AB(a, b)
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox('4A^3 + 27B^2  is nonzero', 'Error', 'error', CreateStruct);
    return;
end
% THIET LAP LAI TUA DE Y^2 = X^3 + AX + B
[signal1, signal2] = set_Title(a, b, handles.lb_sign1, handles.lb_sign2, handles.lb_factorA, handles.lb_factorB);
% KIEM TRA DIEM (PX,PY) CO THOA MAN DO THI
if ~infinite_belongGraph(px, py, a, b)
    str = ['P(x,y)  Invalid', char(10), '(', num2str(py), ')^2 != (', num2str(px), ')^3 ', signal1, ' ', num2str(abs(a)), '(', num2str(px), ') ', signal2, ' ', num2str(abs(b))];
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox(str, 'Invalid','error', CreateStruct);
    set(handles.eb_pqx_infinite, 'string', []);
    set(handles.eb_pqy_infinite, 'string', []);
    return;
end
% KIEM TRA DIEM (QX,QY) CO THOA MAN DO THI
if ~infinite_belongGraph(qx, qy, a, b)
    str = ['Q(x,y)  Invalid', char(10), '(', num2str(qy), ')^2 != (', num2str(qx), ')^3 ', signal1, ' ', num2str(abs(a)), '(', num2str(qx), ') ', signal2, ' ', num2str(abs(b))];
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox(str, 'Invalid','error', CreateStruct);
    set(handles.eb_pqx_infinite, 'string', []);
    set(handles.eb_pqy_infinite, 'string', []);
    return;
end
% TINH P + Q
if px ~= qx || py ~= qy
    R = P_add_Q_infinite(px, py, qx, qy);
else
    R = PointDouble_infinite(px, py, a);
end
rx = R(1);
ry = R(2);
% HIEN THI GIA TRI TINH DUOC LEN GIAO DIEN
set(handles.eb_pqx_infinite, 'string', num2str(rx));
set(handles.eb_pqy_infinite, 'string', num2str(ry));
%TINH VECTOR GIUA 2 DIEM P VA Q
vectorPQx = qx - px;
vectorPQy = qy - py;
% SO SANH DE QUYET DINH HE TRUC TOA DO
if rx < px
   x1 = rx - 5;
   x2 = px + 5;
else
   x1 = px - 5;
   x2 = rx + 5;
end
if ry < py
   y1 = ry - 5;
   y2 = py + 5;
else
   y1 = py - 5;
   y2 = ry + 5;
end
% MO PHONG
clf(figure(2));
figure(2);
hold on;
title('Elliptic Curve point addition (R)', 'fontsize', 13, 'color', 'b');
x = linspace(x1, x2, 550);
y = linspace(y1, y2, 550);
[x,y] = meshgrid(x,y);
grid on;
contour(x,y,y.^2 - (x.^3 + a*x + b),'LevelList', 0, 'LineWidth', 2.3, 'color', 'r'); %DO THI ELLIPTIC
% pause(1);
P = plot(px, py, 'bo', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor','w'); %DIEM P
text(px, py + 0.9, 'Q', 'Color', 'k', 'FontSize', 18);
% pause(1);
Q = plot(qx, qy, 'bo', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor','w'); %DIEM Q
text(qx, qy - 0.9, 'P', 'Color', 'k', 'FontSize', 18);
% pause(1);
delete(P);
delete(Q);
contour(x,y,((x-px)/vectorPQx) - ((y-py)/vectorPQy),'LevelList',0, 'LineWidth', 1.5, 'color', 'm'); %DUONG THANG PQ
plot(px, py, 'bo', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor','w'); %DIEM P
plot(qx, qy, 'bo', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor','w'); %DIEM Q
% pause(1);
R1 = plot(rx, -ry, 'bo', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor','w'); %DIEM -R
text(rx, -ry - 0.9, '-R', 'Color', 'k', 'FontSize', 18);
% pause(1);
delete(R1);
plot([rx rx], [ry -ry], 'k--', 'color', 'm'); %DOAN THANG GIUA 2 DIEM R VA -R
plot(rx, -ry, 'bo', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor','w'); %DIEM -R
% pause(1);
plot(rx, ry, 'bo', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor','w'); %DIEM R
text(rx, ry - 0.9, 'R', 'Color', 'k', 'FontSize', 18);



% --- Executes on button press in btn_np_infinite.
function btn_np_infinite_Callback(hObject, eventdata, handles)
% LAY CAC GIA TRI TU GIAO DIEN XUONG
set_flag(true);
[a,b,px,py,~,~,n] = getValueFromGUI_infinite(handles.eb_factora, handles.eb_factorb, handles.eb_px_infinite, handles.eb_py_infinite, handles.eb_qx_infinite, handles.eb_qy_infinite, handles.eb_n_infinite);
if ~get_flag
   set(handles.eb_npx_infinite, 'string', []);
   set(handles.eb_npy_infinite, 'string', []);
   return; 
end
% KIEM TRA 4A^3 + 27B^2 CO = 0 ?
if ~condition_AB(a, b)
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox('4A^3 + 27B^2  is nonzero', 'Error', 'error', CreateStruct);
    return;
end
% THIET LAP LAI TUA DE Y^2 = X^3 + AX + B
[signal1, signal2] = set_Title(a, b, handles.lb_sign1, handles.lb_sign2, handles.lb_factorA, handles.lb_factorB);
% KIEM TRA DIEM (PX,PY) CO THOA MAN DO THI
if ~infinite_belongGraph(px, py, a, b)
    str = ['P(x,y)  Invalid', char(10), '(', num2str(py), ')^2 != (', num2str(px), ')^3 ', signal1, ' ', num2str(abs(a)), '(', num2str(px), ') ', signal2, ' ', num2str(abs(b))];
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox(str, 'Invalid','error', CreateStruct);
    set(handles.eb_npx_infinite, 'string', []);
    set(handles.eb_npy_infinite, 'string', []);
    return;
end
% TINH n.P
R = [px, py];
if px == Inf || py == Inf
    R(1) = Inf;
    R(2) = Inf;
else
  if n >= 2
      R = PointDouble_infinite(R(1), R(2), a);
      if n ~= 2
          for i = 1:(n-2)
              R = P_add_Q_infinite(R(1), R(2), px, py);
          end
      end
  end
end
rx = R(1);
ry = R(2);
% HIEN THI GIA TRI TINH DUOC LEN GIAO DIEN
set(handles.eb_npx_infinite, 'string', num2str(rx));
set(handles.eb_npy_infinite, 'string', num2str(ry));
% SO SANH DE QUYET DINH HE TRUC TOA DO
if rx < px
   x1 = rx - 5;
   x2 = px + 5;
else
   x1 = px - 5;
   x2 = rx + 5;
end
if ry < py
   y1 = ry - 5;
   y2 = py + 5;
else
   y1 = py - 5;
   y2 = ry + 5;
end
% MO PHONG
clf(figure(2));
figure(2);
hold on;
title('Elliptic Curve scalar multiplication (R)', 'fontsize', 13, 'color', 'b');
x = linspace(x1, x2, 550);
y = linspace(y1, y2, 550);
[x,y] = meshgrid(x,y);
grid on;
contour(x,y,y.^2 - (x.^3 + a*x + b),'LevelList', 0, 'LineWidth', 2.3, 'color', 'r'); %DO THI ELLIPTIC
% pause(1);
plot(px, py, 'bo', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor','w'); %DIEM P
text(px, py + 0.9, 'P', 'Color', 'k', 'FontSize', 18);
% pause(1);
R1 = plot(rx, -ry, 'bo', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor','w'); %DIEM -R
text(rx, -ry - 0.9, ['-',num2str(n),'P'], 'Color', 'k', 'FontSize', 18);
% pause(1);
delete(R1);
plot([rx rx], [ry -ry], 'k--', 'color', 'm'); %DOAN THANG GIUA 2 DIEM R VA -R
plot(rx, -ry, 'bo', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor','w'); %DIEM -R
% pause(1);
plot(rx, ry, 'bo', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor','w'); %DIEM R
text(rx, ry - 0.9, [num2str(n),'P'], 'Color', 'k', 'FontSize', 18);



% --- Executes on selection change in lb_grouporder_finite.
function lb_grouporder_finite_Callback(hObject, eventdata, handles)
% LAY CAC GIA TRI TU GIAO DIEN XUONG
[a,b,module,~,~,~,~,~] = getValueFromGUI_finite(handles.eb_factora, handles.eb_factorb, handles.eb_module_finite, handles.popup_px_finite, handles.popup_py_finite, handles.popup_qx_finite, handles.popup_qy_finite, handles.eb_n_finite);
% LAY DIEM (type: string) TRONG LISTBOX
index_selected = get(hObject,'Value');
list = cellstr( get(hObject, 'string') );
item_selected = list{index_selected}; % Convert from cell array to string
item_selected = sscanf(item_selected, '%dG = (%d,%d)');
x = item_selected(2);
y = item_selected(3);
% MO PHONG
clf(figure(1));
figure(1);
hold on;
title(['Elliptic Curve Points (F_{' module '})'], 'fontsize', 13, 'color', 'b');
simulation_Finite(module, a, b);
plot(x, y, 'gs', 'LineWidth', 2, 'MarkerSize', 10, 'MarkerFaceColor','r');



% --- Executes on button press in btn_pq_finite.
function btn_pq_finite_Callback(hObject, eventdata, handles)
% LAY CAC GIA TRI TU GIAO DIEN XUONG
[a,b,module,px,py,qx,qy,~] = getValueFromGUI_finite(handles.eb_factora, handles.eb_factorb, handles.eb_module_finite, handles.popup_px_finite, handles.popup_py_finite, handles.popup_qx_finite, handles.popup_qy_finite, handles.eb_n_finite);
% KIEM TRA 4A^3 + 27B^2 CO = 0 ?
if ~condition_AB(a, b)
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox('4A^3 + 27B^2  is nonzero', 'Error', 'error', CreateStruct);
    return;
end
% THIET LAP LAI TUA DE Y^2 = X^3 + AX + B
[signal1, signal2] = set_Title(a, b, handles.lb_sign1, handles.lb_sign2, handles.lb_factorA, handles.lb_factorB);
% KIEM TRA MODULE CO PHAI LA SO NGUYEN TO
if ~isPrime(module)
    text = ['Module = [', num2str(module), ']', char(10), num2str(module), ' is not prime!'];
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox(text, 'Invalid', 'error', CreateStruct);
    return;    
end
% HIEN THI TUA DE "F{module}" LEN UIPANEL
p = get(handles.eb_module_finite, 'string');
set(handles.uipanelfp, 'title', [' F{',p,'} ']);
% KIEM TRA DIEM (PX,PY) CO THOA MAN DO THI
if ~finite_belongGraph(px, py, a, b, module)
    text = ['P(x,y) Invalid', char(10), '(', num2str(py), ')^2 (mod ', num2str(module), ')  !=  (', num2str(px), ')^3 ', signal1, ' ', num2str(abs(a)), '(', num2str(px), ') ', signal2, ' ', num2str(abs(b)), ' (mod ', num2str(module), ')'];
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox(text, 'Invalid','error', CreateStruct);
    return;
end
% KIEM TRA DIEM (QX,QY) CO THOA MAN DO THI
if ~finite_belongGraph(qx, qy, a, b, module)
    text = ['Q(x,y) Invalid', char(10), '(', num2str(qy), ')^2 (mod ', num2str(module), ')  !=  (', num2str(qx), ')^3 ', signal1, ' ', num2str(abs(a)), '(', num2str(qx), ') ', signal2, ' ', num2str(abs(b)), ' (mod ', num2str(module), ')'];
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox(text, 'Invalid','error', CreateStruct);
    return;
end
% TINH P + Q
if px ~= qx || py ~= qy
    R = P_add_Q_finite(px, py, qx, qy, module);
else
    R = PointDouble_finite(px,py, module, a);
end
x = R(1);
y = R(2);
% HIEN THI GIA TRI TINH DUOC LEN GIAO DIEN
set(handles.eb_pqx_finite, 'string', num2str(x));
set(handles.eb_pqy_finite, 'string', num2str(y));
% TINH TAT CA CAC DIEM NAM TRONG TRUONG GIOI HAN "MODULE"
[~,numberPoints] = compute_AllPointsFinite(module, a, b);
% HIEN THI SO LUONG DIEM TRONG TRUONG GIOI HAN "MODULE"
set(handles.txt_curvehas_finite, 'string', ['Curve has ', num2str(numberPoints), ' points', char(10), '(including the point at infinity)']);
% MO PHONG
clf(figure(1));
figure(1);
hold on;
title(['Elliptic Curve point addition (F_{' num2str(module) '})'], 'fontsize', 13, 'color', 'b');
simulation_Finite(module, a, b);
plot(x, y, 'gs', 'LineWidth', 2, 'MarkerSize', 10, 'MarkerFaceColor','r');


% --- Executes on button press in btn_np_finite.
function btn_np_finite_Callback(hObject, eventdata, handles)
% LAY CAC GIA TRI TU GIAO DIEN XUONG
[a,b,module,px,py,~,~,n] = getValueFromGUI_finite(handles.eb_factora, handles.eb_factorb, handles.eb_module_finite, handles.popup_px_finite, handles.popup_py_finite, handles.popup_qx_finite, handles.popup_qy_finite, handles.eb_n_finite);
% KIEM TRA 4A^3 + 27B^2 CO = 0 ?
if ~condition_AB(a, b)
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox('4A^3 + 27B^2  is nonzero', 'Error', 'error', CreateStruct);
    return;
end
% THIET LAP LAI TUA DE Y^2 = X^3 + AX + B
set_Title(a, b, handles.lb_sign1, handles.lb_sign2, handles.lb_factorA, handles.lb_factorB);
% KIEM TRA MODULE CO PHAI LA SO NGUYEN TO
if ~isPrime(module)
    str = ['Module = [', num2str(module), ']', char(10), num2str(module), ' is not prime!'];
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox(str, 'Invalid', 'error', CreateStruct);
    return;
end
% HIEN THI TUA DE "F{module}" LEN UIPANEL
p = get(handles.eb_module_finite, 'string');
set(handles.uipanelfp, 'title', [' F{',p,'} ']);
% KIEM TRA DIEM (PX,PY) CO THOA MAN DO THI
if ~finite_belongGraph(px, py, a, b, module)
    str = ['BasePoint Invalid', char(10), '(', num2str(py), ')^2 (mod ', num2str(module), ')  !=  (', num2str(px), ')^3 ', signal1, ' ', num2str(abs(a)), '(', num2str(px), ') ', signal2, ' ', num2str(abs(b)), ' (mod ', num2str(module), ')'];
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox(str, 'Invalid','error', CreateStruct);
    return;
end
% TINH n.P
global x y
subgroup = subgroup_finite(px, py, module, a);
numofsubPoints = length(subgroup);
if n <= numofsubPoints
   x = subgroup(n,1);
   y = subgroup(n,2);
else
   x = subgroup(mod(n,numofsubPoints),1);
   y = subgroup(mod(n,numofsubPoints),2);
end
% HIEN THI GIA TRI TINH DUOC LEN GIAO DIEN
set(handles.eb_npx_finite, 'string', num2str(x));
set(handles.eb_npy_finite, 'string', num2str(y));
% LIET KE CAC DIEM (SUB POINTS) VAO LISTBOX
set(handles.lb_grouporder_finite, 'string', []);
Points = subgroup_finite(px, py, module, a);
numofsubPoints = length(Points);
for i = 1 : numofsubPoints
   str = [num2str(i), 'G = (', num2str(Points(i,1)), ', ', num2str(Points(i,2)), ')'];
   old_str = get(handles.lb_grouporder_finite, 'string');
   new_str = strvcat(old_str, str);
   set(handles.lb_grouporder_finite, 'string', new_str);
end
% TINH TAT CA CAC DIEM NAM TRONG TRUONG GIOI HAN "MODULE"
[~,numberPoints] = compute_AllPointsFinite(module, a, b);
% HIEN THI SO LUONG DIEM TRONG TRUONG GIOI HAN "MODULE"
set(handles.txt_curvehas_finite, 'string', ['Curve has ', num2str(numberPoints), ' points', char(10), '(including the point at infinity)']);
set(handles.txt_subgroup_finite, 'string', ['The subgroup generated by P has ', num2str(numofsubPoints), ' points']);
% MO PHONG
clf(figure(1));
figure(1);
hold on;
title(['Elliptic Curve scalar multiplication (F_{' num2str(module) '})'], 'fontsize', 13, 'color', 'b');
simulation_Finite(module, a, b);
plot(x, y, 'gs', 'LineWidth', 2, 'MarkerSize', 10, 'MarkerFaceColor','r');



function eb_module_finite_KeyPressFcn(hObject, eventdata, handles)
% NHAN PHIM "ENTER" TRONG EDITTEXT MODULE 
kbrin=eventdata.Key;
if strcmp(kbrin,'return')
    % LAY CAC GIA TRI TU GIAO DIEN XUONG
    [a,b,p,~,~,~,~,~] = getValueFromGUI_finite(handles.eb_factora, handles.eb_factorb, handles.eb_module_finite, handles.popup_px_finite, handles.popup_py_finite, handles.popup_qx_finite, handles.popup_qy_finite, handles.eb_n_finite);
    % TINH TAT CA CAC DIEM NAM TRONG TRUONG GIOI HAN "MODULE"
    [points,numberPoints] = compute_AllPointsFinite(p, a, b);
    %KIEM TRA MODULE CO PHAI LA SO NGUYEN TO
    if ~isPrime(p)
        str = ['Module = [', num2str(p), ']', char(10), num2str(p), ' is not prime!'];
        CreateStruct.Interpreter = 'tex';
        CreateStruct.WindowStyle = 'modal';
        msgbox(str, 'Invalid', 'error', CreateStruct);
        % XOA (SUB POINTS) TRONG LISTBOX
        set(handles.lb_grouporder_finite, 'string', []);
        % HIEN THI STATICTEXT LAI MAC DINH
        set(handles.txt_curvehas_finite, 'string', ['Curve has ? points', char(10), '(including the point at infinity)']);
        set(handles.txt_subgroup_finite, 'string', 'The subgroup generated by P has ? points');
        return;
    end
    set(handles.uipanelfp, 'title', [' F{',num2str(p),'} ']);
    % HIEN THI SO LUONG DIEM TRONG TRUONG GIOI HAN "MODULE"
    set(handles.txt_curvehas_finite, 'string', ['Curve has ', num2str(numberPoints), ' points', char(10), '(including the point at infinity)']);
    % CAP NHAT P(X,Y) VA Q(X,Y) TRONG "FINITE"
    for i = 1:numberPoints
        % CAP NHAT P
        px{i}= num2str(points(i,1));
        set(handles.popup_px_finite, 'String', px);
        py{i}= num2str(points(i,2));
        set(handles.popup_py_finite, 'String', py);
        % CAP NHAT Q
        qx{i}= num2str(points(i,1));
        set(handles.popup_qx_finite, 'String', qx);
        qy{i}= num2str(points(i,2));
        set(handles.popup_qy_finite, 'String', qy);
    end
    guidata(hObject,handles);
end


function popup_px_finite_Callback(hObject, eventdata, handles)
% LAY VI TRI CUA ITEM CHON TRONG PX
index = get(handles.popup_px_finite,'Value');
% TRA VE GIA TRI TUONG UNG TRONG PY TUONG UNG VS VI TRI CUA PX
set(handles.popup_py_finite, 'value', index);


function popup_py_finite_Callback(hObject, eventdata, handles)
% LAY VI TRI CUA ITEM CHON TRONG PY
index = get(handles.popup_py_finite,'Value');
% TRA VE GIA TRI TUONG UNG TRONG PX TUONG UNG VS VI TRI CUA PY
set(handles.popup_px_finite, 'value', index);


function popup_qx_finite_Callback(hObject, eventdata, handles)
% LAY VI TRI CUA ITEM CHON TRONG QX
index = get(handles.popup_qx_finite,'Value');
% TRA VE GIA TRI TUONG UNG TRONG QY TUONG UNG VS VI TRI CUA QX
set(handles.popup_qy_finite, 'value', index);


function popup_qy_finite_Callback(hObject, eventdata, handles)
% LAY VI TRI CUA ITEM CHON TRONG QY
index = get(handles.popup_qy_finite,'Value');
% TRA VE GIA TRI TUONG UNG TRONG QX TUONG UNG VS VI TRI CUA QY
set(handles.popup_qx_finite, 'value', index);


% --- Executes on key press with focus on eb_px_infinite and none of its controls.
function eb_px_infinite_KeyPressFcn(hObject, eventdata, handles)
% NHAN PHIM "ENTER" TRONG EDITTEXT QX DE QY NHAN GIA TRI TUONG UNG
kbrin = eventdata.Key;
if strcmp(kbrin,'return')
    %LAY CAC GIA TRI TU GIAO DIEN XUONG
    [a,b,px,~,~,~,~] = getValueFromGUI_infinite(handles.eb_factora, handles.eb_factorb, handles.eb_px_infinite, handles.eb_py_infinite, handles.eb_qx_infinite, handles.eb_qy_infinite, handles.eb_n_infinite);
    py = sqrt(px.^3 + a*px + b);
    set(handles.eb_py_infinite, 'string', num2str(py));
end



% --- Executes on key press with focus on eb_py_infinite and none of its controls.
function eb_py_infinite_KeyPressFcn(hObject, eventdata, handles)
% NHAN PHIM "ENTER" TRONG EDITTEXT QY DE QX NHAN GIA TRI TUONG UNG
kbrin = eventdata.Key;
if strcmp(kbrin,'return')
    %LAY CAC GIA TRI TU GIAO DIEN XUONG
    [a,b,~,py,~,~,~] = getValueFromGUI_infinite(handles.eb_factora, handles.eb_factorb, handles.eb_px_infinite, handles.eb_py_infinite, handles.eb_qx_infinite, handles.eb_qy_infinite, handles.eb_n_infinite);
    b = b - py.^2;   %CHUYEN THANH: X^3 + AX + B - Y^2 = 0
    eqn = [1 0 a b]; %HE SO TUONG UNG VOI SO MU
    px = roots(eqn); %TIM X
    set(handles.eb_qx_infinite, 'string', num2str(px(3)));
end



% --- Executes on key press with focus on eb_qx_infinite and none of its controls.
function eb_qx_infinite_KeyPressFcn(hObject, eventdata, handles)
% NHAN PHIM "ENTER" TRONG EDITTEXT QX DE QY NHAN GIA TRI TUONG UNG
kbrin = eventdata.Key;
if strcmp(kbrin,'return')
    %LAY CAC GIA TRI TU GIAO DIEN XUONG
    [a,b,~,~,qx,~,~] = getValueFromGUI_infinite(handles.eb_factora, handles.eb_factorb, handles.eb_px_infinite, handles.eb_py_infinite, handles.eb_qx_infinite, handles.eb_qy_infinite, handles.eb_n_infinite);
    %TINH QY
    qy = sqrt(qx.^3 + a*qx + b);
    set(handles.eb_qy_infinite, 'string', num2str(qy));
end



% --- Executes on key press with focus on eb_qy_infinite and none of its controls.
function eb_qy_infinite_KeyPressFcn(hObject, eventdata, handles)
% NHAN PHIM "ENTER" TRONG EDITTEXT QY DE QX NHAN GIA TRI TUONG UNG
kbrin = eventdata.Key;
if strcmp(kbrin,'return')
    %LAY CAC GIA TRI TU GIAO DIEN XUONG
    [a,b,~,~,~,qy,~] = getValueFromGUI_infinite(handles.eb_factora, handles.eb_factorb, handles.eb_px_infinite, handles.eb_py_infinite, handles.eb_qx_infinite, handles.eb_qy_infinite, handles.eb_n_infinite);
    b = b - qy.^2;   %CHUYEN THANH: X^3 + AX + B - Y^2 = 0
    eqn = [1 0 a b]; %HE SO TUONG UNG VOI SO MU
    qx = roots(eqn); %TIM X
    set(handles.eb_qx_infinite, 'string', num2str(qx(3)));
end


function eb_factora_KeyPressFcn(hObject, eventdata, handles)
kbrin = eventdata.Key;
if strcmp(kbrin,'return')
    axes(handles.smallgraph);
    cla;
    hold on;
    a = str2double(get(handles.eb_factora, 'string'));
    b = str2double(get(handles.eb_factorb, 'string'));
    [x,y] = meshgrid(linspace(-5,5,550));
    contour(x,y,y.^2 - (x.^3 + a*x + b),'LevelList',0, 'LineWidth', 2, 'color', 'm');
    grid on;
    
    % TINH TAT CA CAC DIEM NAM TRONG TRUONG GIOI HAN "MODULE"
    p = str2double(get(handles.eb_module_finite, 'string'));
    [points,numberPoints] = compute_AllPointsFinite(p, a, b);
    %KIEM TRA MODULE CO PHAI LA SO NGUYEN TO
    if ~isPrime(p)
        str = ['Module = [', num2str(p), ']', char(10), num2str(p), ' is not prime!'];
        CreateStruct.Interpreter = 'tex';
        CreateStruct.WindowStyle = 'modal';
        msgbox(str, 'Invalid', 'error', CreateStruct);
        return;
    end
    set(handles.uipanelfp, 'title', [' F{',num2str(p),'} ']);
    % CAP NHAT P(X,Y) VA Q(X,Y) TRONG "FINITE"
    for i = 1:numberPoints
        % CAP NHAT P
        px{i}= num2str(points(i,1));
        set(handles.popup_px_finite, 'String', px);
        py{i}= num2str(points(i,2));
        set(handles.popup_py_finite, 'String', py);
        % CAP NHAT Q
        qx{i}= num2str(points(i,1));
        set(handles.popup_qx_finite, 'String', qx);
        qy{i}= num2str(points(i,2));
        set(handles.popup_qy_finite, 'String', qy);
    end
    % XOA (SUB POINTS) TRONG LISTBOX - "FINITE"
    set(handles.lb_grouporder_finite, 'string', []);
    % HIEN THI STATICTEXT LAI MAC DINH - "FINITE"
    set(handles.txt_curvehas_finite, 'string', ['Curve has ? points', char(10), '(including the point at infinity)']);
    set(handles.txt_subgroup_finite, 'string', 'The subgroup generated by P has ? points');
    guidata(hObject,handles);
end


function eb_factorb_KeyPressFcn(hObject, eventdata, handles)
kbrin = eventdata.Key;
if strcmp(kbrin,'return')
    axes(handles.smallgraph);
    cla;
    hold on;
    a = str2double(get(handles.eb_factora, 'string'));
    b = str2double(get(handles.eb_factorb, 'string'));
    [x,y] = meshgrid(linspace(-5,5,550));
    contour(x,y,y.^2 - (x.^3 + a*x + b),'LevelList',0, 'LineWidth', 2, 'color', 'm');
    grid on;
    
    % TINH TAT CA CAC DIEM NAM TRONG TRUONG GIOI HAN "MODULE"
    p = str2double(get(handles.eb_module_finite, 'string'));
    [points,numberPoints] = compute_AllPointsFinite(p, a, b);
    %KIEM TRA MODULE CO PHAI LA SO NGUYEN TO
    if ~isPrime(p)
        str = ['Module = [', num2str(p), ']', char(10), num2str(p), ' is not prime!'];
        CreateStruct.Interpreter = 'tex';
        CreateStruct.WindowStyle = 'modal';
        msgbox(str, 'Invalid', 'error', CreateStruct);
        return;
    end
    set(handles.uipanelfp, 'title', [' F{',num2str(p),'} ']);
    % CAP NHAT P(X,Y) VA Q(X,Y) TRONG "FINITE"
    for i = 1:numberPoints
        % CAP NHAT P
        px{i}= num2str(points(i,1));
        set(handles.popup_px_finite, 'String', px);
        py{i}= num2str(points(i,2));
        set(handles.popup_py_finite, 'String', py);
        % CAP NHAT Q
        qx{i}= num2str(points(i,1));
        set(handles.popup_qx_finite, 'String', qx);
        qy{i}= num2str(points(i,2));
        set(handles.popup_qy_finite, 'String', qy);
    end
    % XOA (SUB POINTS) TRONG LISTBOX - "FINITE"
    set(handles.lb_grouporder_finite, 'string', []);
    % HIEN THI STATICTEXT LAI MAC DINH - "FINITE"
    set(handles.txt_curvehas_finite, 'string', ['Curve has ? points', char(10), '(including the point at infinity)']);
    set(handles.txt_subgroup_finite, 'string', 'The subgroup generated by P has ? points');
    guidata(hObject,handles);
end





% ------------------------- END FUNCTION -------------------------









function eb_factora_Callback(hObject, eventdata, handles)

function eb_factora_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eb_factorb_Callback(hObject, eventdata, handles)

function eb_factorb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eb_module_finite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popup_px_finite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popup_py_finite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lb_grouporder_finite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edpoints_Callback(hObject, eventdata, handles)

function edpoints_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eb_px_infinite_Callback(hObject, eventdata, handles)

function eb_px_infinite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eb_py_infinite_Callback(hObject, eventdata, handles)

function eb_py_infinite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eb_qy_infinite_Callback(hObject, eventdata, handles)

function eb_qy_infinite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eb_qx_infinite_Callback(hObject, eventdata, handles)

function eb_qx_infinite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eb_n_infinite_Callback(hObject, eventdata, handles)

function eb_n_infinite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eb_pqy_infinite_Callback(hObject, eventdata, handles)

function eb_pqy_infinite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eb_pqx_infinite_Callback(hObject, eventdata, handles)

function eb_pqx_infinite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eb_npy_infinite_Callback(hObject, eventdata, handles)

function eb_npy_infinite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eb_npx_infinite_Callback(hObject, eventdata, handles)

function eb_npx_infinite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit19_Callback(hObject, eventdata, handles)

function edit19_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit20_Callback(hObject, eventdata, handles)

function edit20_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popup_qy_finite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popup_qx_finite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eb_n_finite_Callback(hObject, eventdata, handles)

function eb_n_finite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eb_pqy_finite_Callback(hObject, eventdata, handles)

function eb_pqy_finite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eb_pqx_finite_Callback(hObject, eventdata, handles)

function eb_pqx_finite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eb_npy_finite_Callback(hObject, eventdata, handles)

function eb_npy_finite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eb_npx_finite_Callback(hObject, eventdata, handles)

function eb_npx_finite_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
