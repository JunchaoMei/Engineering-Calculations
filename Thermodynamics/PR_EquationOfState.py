# -*- coding: utf-8 -*-
"""
Created on Sun Nov 06 21:11:46 2016

@author: vidyavijay
"""

#Ammonia
#Peng Robinson
import scipy
import numpy as np
from scipy import roots
import matplotlib.pyplot as plt

#Thermodynamics 
#Declaring constants
T1=200 #K
T2=450 #K
Tc=405.4 #K
P1=0.06*101325 #Pa
P2=2.09*101325 #Pa
Pc=113.53*101325 #Pa
Zc=0.2441
MW=17.031 #g/mol
Vc=72.47*10**-6 #m3/mol
om=0.257 #w
Tr1=T1/Tc
Tr2=T2/Tc
R=8.314 #J/mol K
a=0.45724*(R**2)*(Tc**2)/Pc
b=0.0778*R*Tc/Pc
K=0.37464+1.54226*om-0.26992*om**2


#At temperature T1 and pressure P1
alp1=(1+(K*(1-(Tr1**0.5))))**2
#((Z**3)-((1-B)*Z**2)+(A-2*B-3*B**2)*Z-(A*B-B**2-B**3))
A1=(a*alp1*P1)/((R**2)*(T1**2))
B1=(b*P1)/(R*T1)
a10=-(A1*B1-B1**2-B1**3) #Coeff of z^0
a11=(A1-2*B1-3*B1**2) #Coeff of z^1
a12=-(1-B1) #Coeff of z^2
a13=1 #Coeff of z^3
coeff1=[a13,a12,a11,a10]
y1=np.roots(coeff1)
z1=min(y1)
print ('z value for liquid is'), z1
V1=z1*R*T1/P1
print ('Volume of liquid is'), V1,('m3/mol')
#At temperature T2 and pressure P2
alp2=(1+(K*(1-(Tr2**0.5))))**2
#((Z**3)-((1-B)*Z**2)+(A-2*B-3*B**2)*Z-(A*B-B**2-B**3))
A2=(a*alp2*P2)/((R**2)*(T2**2))
B2=(b*P2)/(R*T2)
a20=-(A2*B2-B2**2-B2**3) #Coeff of z^0
a21=(A2-2*B2-3*B2**2) #Coeff of z^1
a22=-(1-B2) #Coeff of z^2
a23=1 #Coeff of z^3
coeff2=[a23,a22,a21,a20]
y2=np.roots(coeff2)
z2=max(y2)
print ('z value for vapour is'),scipy.absolute(z2)
V2=z2*R*T2/P2
print ('Volume of vapour is'),scipy.absolute(V2),('m3/mol')
#Taking inputs from user to calculate for liquid or vapour
user_inp=int(input('Determine if liquid or vapour properties are desired, Enter 0 for liquid and 1 for vapour'))
print ('User input is'),user_inp

#Calculating properties based on user input
if user_inp==0:
    print('Calculating liquid properties')
    T=T1
    P=P1
    V=V1
    alp=alp1
    z=z1
elif user_inp==1:
    print('Calculating vapour properties')
    T=T2
    P=P2
    V=V2
    alp=alp2
    z=z2

#Statistical mechanics
#AMMONIA=polyatomic non-linear molecule
#Declaring constants
Uo=1.158*10**6 #Ground state energy
sigma=3
Nmodes=6
qrot_theta=[13.6,13.6,8.92]
qvib_t=[1360,2330,2330,4800,4880,4880]
h=6.626*10**-34 #J.s (Planck's constant)
kb=1.381*10**-23 #J/K (Boltzmann constant)
Av=6.022*10**23 #1/mol (Avogadro's number)
au=1.66*10**-27 #kg (atomic mass unit) 
m=MW*au #(kg)Mass of ammonia

#del_H by statistical mechanics
n=10
del_x=(T2-T1)/n
for i in range(0,n):
    Ti=T1+i*del_x
    for j in range (0,Nmodes-1): 
        Cv_sum=0
        Cv_new=R*(3+((((qvib_t[j]/(Ti))**2)*scipy.exp(-qvib_t[j]/(Ti)))/((1-scipy.exp(-qvib_t[j]/(Ti)))**2)))
        j=j+1
    if i==0:
        Cv_sum=Cv_sum+Cv_new
    elif i==n:
        Cv_sum=Cv_sum+Cv_new
    else:
        Cv_sum=Cv_sum+2*Cv_new
    i=i+1
Cp_sum=Cv_sum+R
int_Cp_H=(del_x*Cp_sum)/2

#Departure finctions
#del_H at T1,P1
del_H1=(R*T1)-(P1*V1)-((a*alp1/(2.828*b))*(1+(K*((T1/(alp1*Tc))**(0.5))))*scipy.log((V1-0.414*b)/(V1+2.414*b)))
print ('Delta H at final condition is'), scipy.absolute(del_H1)*0.001,('kJ/mol')
#del_H at T2,P2
del_H2=(R*T2)-(P2*V2)-((a*alp2/(2.828*b))*(1+(K*((T2/(alp2*Tc))**(0.5))))*scipy.log((V2-0.414*b)/(V2+2.414*b)))
print ('Delta H at initial condition is'), scipy.absolute(del_H2)*0.001,('kJ/mol')
del_H_sm=del_H1-del_H2-int_Cp_H
print ('Departure function Delta H is'), scipy.absolute(del_H_sm)*0.001,('kJ/mol')

#del_S by statistical mechanics
n=10
del_x=(T2-T1)/n
for i in range(0,n):
    Ti=T1+i*del_x
    for j in range (0,Nmodes-1): 
        Cp_sum=0
        Cp_new=((R*(3+((((qvib_t[j]/(Ti))**2)*scipy.exp(-qvib_t[j]/(Ti)))/((1-scipy.exp(-qvib_t[j]/(Ti)))**2))))+R)/Ti
        j=j+1
    if i==0:
        Cp_sum=Cp_sum+Cp_new
    elif i==n:
        Cp_sum=Cp_sum+Cp_new
    else:
        Cp_sum=Cp_sum+2*Cp_new
    i=i+1
int_Cp_S=(del_x*Cp_sum)/2
#del_S at T1,P1
del_S1=R*(scipy.log(R*T1/((V1-b)*P1)))-(a*K/(4*b)*(((2*alp1)/(T1*Tc))**(0.5))*scipy.log((V1-0.414*b)/(V1+2.414*b)))
print('Delta S at final condition is'), scipy.absolute(del_S1), ('J/mol K')
#del_S at T2,P2
del_S2=R*(scipy.log(R*T2/((V2-b)*P2)))-(a*K/(4*b)*(((2*alp2)/(T2*Tc))**(0.5))*scipy.log((V2-0.414*b)/(V2+2.414*b)))
print('Delta S at initial condition is'), scipy.absolute(del_S2), ('J/mol K')
term4_S=R*(scipy.log(P2/P1))
del_S_sm=del_S1-del_S2-int_Cp_S-term4_S
print('Departure function Delta S is'), scipy.absolute(del_S_sm), ('J/mol K')

#Calculating integral S(T1,T2)
n=10
del_x=(T2-T1)/n
for i in range(0,n):
    S_sum=0
    Ti=T1+i*del_x
    qtrans=(2*scipy.pi*m*kb*Ti/(h**2))**(1.5)  #translational 
    V=qtrans*R*Ti/P
    qrot=(((scipy.pi*(Ti**3))/(qrot_theta[0]*qrot_theta[1]*qrot_theta[2]))**(0.5))/3  #rotational
    Um_sum=0    
    qvib_sum=0
    for j in range (0,Nmodes-1):    
        qvib_new=1-scipy.exp(-qvib_t[j]/Ti)
        qvib_sum=qvib_sum+qvib_new
        Um_new=3+((qvib_t[j]*scipy.exp(-qvib_t[j]/Ti))/(Ti*qvib_new))
        Um_sum=Um_sum+Um_new
        j=j+1
    qvib=1/qvib_sum
    qel=1
    q=qtrans*qrot*qvib*qel
    S_new=R*scipy.log(q)+Um_sum/Ti
    if i==0:
        S_sum=S_sum+S_new
    elif i==n:
        S_sum=S_sum+S_new
    else:
        S_sum=S_sum+2*S_new
    i=i+1
int_S=(del_x*S_sum)/2

#del G by statistical mechanics
del_G1=del_H1-(T1*del_S1)
print ('Delta G at final conditions is'), scipy.absolute(del_G1)*0.001, ('kJ/mol')
del_G2=del_H2-(T2*del_S2)
print ('Delta G at initial conditions is'), scipy.absolute(del_G2)*0.001, ('kJ/mol')
term3_G=int_S
term4_G=R*T2*scipy.log(P2/P1)
del_G_sm=del_G1-del_G2-term3_G+term4_G
print ('Departure function Delta G is'), scipy.absolute(del_G_sm)*0.001, ('kJ/mol')
    
#del A
del_V1=((z1-1)*R*T1)/P1
del_V2=((z2-1)*R*T2)/P2
del_A1=del_G1-(P1*del_V1)
print ('Delta A at final condition is'), scipy.absolute(del_A1)*0.001, ('kJ/mol')
del_A2=del_G2-(P2*del_V2)
print ('Delta A at initial condition is'), scipy.absolute(del_A2)*0.001, ('kJ/mol')
term3_A=int_S
term4_A=R*(T2-T1)
term5_A=R*T2*scipy.log(P2/P1)
del_A_sm=del_A1-del_A2-term3_A-term4_A+term5_A
print ('Departure function Delta A is'), scipy.absolute(del_A_sm)*0.001, ('kJ/mol')



