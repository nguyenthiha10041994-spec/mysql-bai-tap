use furama_management;

-- Câu 6 ;dịch vụ chưa từng được đặt trong quý 1 năm 2021
select dv.ma_dich_vu,
       dv.ten_dich_vu,
       dv.dien_tich,
       dv.chi_phi_thue,
       ldv.ten_loai_dich_vu
from dich_vu dv
join loai_dich_vu ldv
on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
where dv.ma_dich_vu not in (
select ma_dich_vu from hop_dong
where year(ngay_lam_hop_dong)=2021 and month(ngay_lam_hop_dong) in (1,2,3)
);

-- Câu7; Dịch vụ được đặt năm 2020 nhưng không được đặt năm 2021
select distinct
       dv.ma_dich_vu,
       dv.ten_dich_vu,
       dv.dien_tich,
       dv.so_nguoi_toi_da,
       dv.chi_phi_thue,
       ldv.ten_loai_dich_vu
from dich_vu dv
join loai_dich_vu ldv on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
join hop_dong hd on dv.ma_dich_vu = hd.ma_dich_vu
where year(hd.ngay_lam_hop_dong)=2020 and dv.ma_dich_vu not in (
select ma_dich_vu from hop_dong
where year(ngay_lam_hop_dong)=2021
);

-- Câu 8;Hiển thị tên khách hàng không trùng nhau
-- cách1
select ho_ten from khach_hang
group by ho_ten;
-- cách 2
select distinct ho_ten from khach_hang;
-- cách 3
select ho_ten from khach_hang
union
select ho_ten from khach_hang;

-- Câu9;Thống kê số khách hàng đặt phòng theo từng tháng năm 2021
select month(ngay_lam_hop_dong) as thang,
       count(distinct ma_khach_hang) as so_luong_khach_hang
from hop_dong
where year(ngay_lam_hop_dong)=2021
group by month(ngay_lam_hop_dong)
order by thang;

-- Câu 10;Thống kê số lượng dịch vụ đi kèm của từng hợp đồng
select hd.ma_hop_dong,
       hd.ngay_lam_hop_dong,
       hd.ngay_ket_thuc,
       hd.tien_dat_coc,
       ifnull(sum(hdct.so_luong),0) as so_luong_dich_vu_di_kem
from hop_dong hd
left join hop_dong_chi_tiet hdct on hd.ma_hop_dong = hdct.ma_hop_dong
group by hd.ma_hop_dong,
         hd.ngay_lam_hop_dong,
         hd.ngay_ket_thuc,
         hd.tien_dat_coc;