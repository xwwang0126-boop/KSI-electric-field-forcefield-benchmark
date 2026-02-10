program ef
implicit none
 integer(kind=4),allocatable::res_atom(:)
 character(len=4),allocatable::restype(:)
 real(kind=8),allocatable::mmcrg(:)
 real(kind=8),allocatable::ambcrg(:)
 real(kind=8),allocatable::crd(:,:)
 real(kind=8)::esp,ex,ey,ez,espc,espn,bond_len
 real(kind=8)::x0,y0,z0
 real(kind=8)::cx,cy,cz,nx,ny,nz,vx,vy,vz,vsx,vsy,vsz

 character*80 pl
 integer*4 ist,number,ntypes,nres,patom

character*50 filename
integer*8 i,j

 real(kind=8)::scalefactor

scalefactor=sqrt(627.51*0.5291772)


open(26,file='pn.top')
open(28,file='top_file_temp.txt')

do
  read(26,'(a80)',iostat=ist)pl
  if(ist.lt.0)exit
  if(pl(1:14).eq.'%FLAG POINTERS')then
     read(26,*)
     read(26,'(a80)')pl
     read(pl(1:8),'(i8)') number
     read(pl(9:16),'(i8)') ntypes
     read(26,'(a80)')pl
     read(pl(9:16),'(i8)') nres
  if(.not.allocated(res_atom))allocate(res_atom(nres))
  if(.not.allocated(restype))allocate(restype(nres))
  if(.not.allocated(mmcrg))allocate(mmcrg(number))
   endif
  if(pl(1:23).eq.'%FLAG CHARGE')then
     read(26,*)
     read(26,'(5E16.8)')mmcrg
     write(28,'(5E16.8)')mmcrg
  endif
  if(pl(1:19).eq.'%FLAG RESIDUE_LABEL')then
    read(26,*)
    read(26,'(20a4)')restype
    write(28,'(20a4)')restype
  endif
  if(pl(1:21).eq.'%FLAG RESIDUE_POINTER')then
    read(26,*)
    read(26,'(10i8)')res_atom
!write(*,'(10i8)')res_atom
  endif
enddo
   write(28,'(10i8)')res_atom
close(26)
close(28)

write(*,'("Protein atom number: ",i8)')res_atom(nres)
patom=number
write(*,'("Atom number: ",i8,"resnum ",i8)')patom,nres

!if(.not.allocated(crd))allocate(crd(3,res_atom(156)-1))
if(.not.allocated(crd))allocate(crd(3,number))
if(.not.allocated(ambcrg))allocate(ambcrg(patom))
do i=1,patom
   ambcrg(i)=mmcrg(i)/scalefactor
enddo


print*, res_atom(127),res_atom(127)+1
read*, filename
open(10,file=filename)
do j=1,15726
read(10,*)
read(10,'(10f8.3)')crd
!write(*,*)crd(1,1),crd(2,1),crd(3,1)
!  write(20,'(10f8.3)')crd
!do i=1,5180
!   write(30,'(3f8.3)')(crd(j,i),j=1,3)
!enddo

cx=crd(1,1943)  !res_atom(155))
cy=crd(2,1943)  !res_atom(155))
cz=crd(3,1943)  !res_atom(155))
nx=crd(1,1944)  !res_atom(155)+1)
ny=crd(2,1944)  !res_atom(155)+1)
nz=crd(3,1944)  !res_atom(155)+1)
vsx=nx-cx
vsy=ny-cy
vsz=nz-cz
vx=vsx/sqrt(vsx**2+vsy**2+vsz**2)
vy=vsy/sqrt(vsx**2+vsy**2+vsz**2)
vz=vsz/sqrt(vsx**2+vsy**2+vsz**2)

!x0=(crd(1,res_atom(319)-3)+crd(1,res_atom(319)-4))/2.0d0
!y0=(crd(2,res_atom(319)-3)+crd(2,res_atom(319)-4))/2.0d0
!z0=(crd(3,res_atom(319)-3)+crd(3,res_atom(319)-4))/2.0d0
x0=(nx+cx)/2.00d0
y0=(ny+cy)/2.00d0
z0=(nz+cz)/2.00d0

write(*,'("C and O :",6f16.9)')cx,cy,cz,nx,ny,nz
write(*,'("center of CO is:",3f16.9)')x0,y0,z0
esp=0.00d0
espc=0.00d0
espn=0.00d0
ex=0.00d0
ey=0.00d0
ez=0.00d0

do i=1,patom
  if(i.ge.1939.and.i.le.1946)cycle
  if(i.ge.1959.and.i.le.1966)cycle

  esp=esp+0.52917721d0*ambcrg(i)/(sqrt((crd(1,i)-x0)**2+(crd(2,i)-y0)**2+(crd(3,i)-z0)**2))
  espc=espc+0.52917721d0*ambcrg(i)/(sqrt((crd(1,i)-cx)**2+(crd(2,i)-cy)**2+(crd(3,i)-cz)**2))
  espn=espn+0.52917721d0*ambcrg(i)/(sqrt((crd(1,i)-nx)**2+(crd(2,i)-ny)**2+(crd(3,i)-nz)**2))
  ex=ex+0.28d0*ambcrg(i)*(x0-crd(1,i))/(sqrt((crd(1,i)-x0)**2+(crd(2,i)-y0)**2+(crd(3,i)-z0)**2))**3
  ey=ey+0.28d0*ambcrg(i)*(y0-crd(2,i))/(sqrt((crd(1,i)-x0)**2+(crd(2,i)-y0)**2+(crd(3,i)-z0)**2))**3
  ez=ez+0.28d0*ambcrg(i)*(z0-crd(3,i))/(sqrt((crd(1,i)-x0)**2+(crd(2,i)-y0)**2+(crd(3,i)-z0)**2))**3
enddo
!write(*,'("esp ex ey ez:",4f16.9)')esp,ex,ey,ez
write(*,'("Field",2f16.9)')esp,((ex*vx+ey*vy+ez*vz)*5142.206d0)
write(18,'(f16.9)')((ex*vx+ey*vy+ez*vz)*5142.206d0)
bond_len=sqrt((cx-nx)**2+(cy-ny)**2+(cz-nz)**2)
print*, bond_len
bond_len=bond_len/0.5291772083d0
write(*,'("Calcuated from Esp",f16.9)')(((espc-espn)/bond_len)*5142.206d0)
write(19,'(f16.9)')(((espc-espn)/bond_len)*5142.206d0)
enddo
close(10)

end
