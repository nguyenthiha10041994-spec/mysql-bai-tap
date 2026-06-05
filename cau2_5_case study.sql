use furama_management;
-- Câu 2;Nhân viên tên H, T, K và <= 15 ký tự
select * from nhan_vien
where (ho_ten like 'H%'or ho_ten like 'T%'or ho_ten like 'K%')
and char_length(ho_ten) <= 15;

-- Câu 3: Hiển thị khách hàng 18-50 tuổi ở Đà Nẵng hoặc Quảng Trị
select * from khach_hang
where timestampdiff(year, ngay_sinh, curdate()) between 18 and 50
and (dia_chi like "%Đà Nẵng%" or dia_chi like "%Quảng Trị%");

-- Câu 4;Đếm số lần đặt phòng của khách hàng Diamond
select kh.ma_khach_hang,kh.ho_ten,count(hd.ma_hop_dong) as so_lan_dat_phong
from khach_hang kh
join loai_khach lk on kh.ma_loai_khach = lk.ma_loai_khach
join hop_dong hd on kh.ma_khach_hang = hd.ma_khach_hang
where lk.ten_loai_khach = "Diamond"
group by kh.ma_khach_hang, kh.ho_ten
order by so_lan_dat_phong;
-- Câu 5: Hiển thị khách hàng và tổng tiền hợp đồng
select kh.ma_khach_hang,
       kh.ho_ten,
       lk.ten_loai_khach,
       hd.ma_hop_dong,
       dv.ten_dich_vu,
       hd.ngay_lam_hop_dong,
       hd.ngay_ket_thuc,
       ifnull(dv.chi_phi_thue,0)
       + ifnull(sum(hdct.so_luong * dvdk.gia),0) as tong_tien
from khach_hang kh
left join loai_khach lk
on kh.ma_loai_khach = lk.ma_loai_khach
left join hop_dong hd
on kh.ma_khach_hang = hd.ma_khach_hang
left join dich_vu dv
on hd.ma_dich_vu = dv.ma_dich_vu
left join hop_dong_chi_tiet hdct
on hd.ma_hop_dong = hdct.ma_hop_dong
left join dich_vu_di_kem dvdk
on hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
group by kh.ma_khach_hang,
         kh.ho_ten,
         lk.ten_loai_khach,
         hd.ma_hop_dong,
         dv.ten_dich_vu,
         hd.ngay_lam_hop_dong,
         hd.ngay_ket_thuc,
         dv.chi_phi_thue
order by kh.ma_khach_hang;

