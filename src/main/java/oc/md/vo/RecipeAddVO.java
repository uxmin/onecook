package oc.md.vo;

import java.awt.Image;
import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import oc.md.domain.Recipe_material;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RecipeAddVO {
	private long rc_idx;
	private String email;
	private String user_type;
	private String rc_title;
	private String rc_type;
	private long rc_num;
	private Date rc_date;
	private String rc_img;
	private MultipartFile rc_img_file;
	
	private List<MultipartFile> image_tb_file;
	private String image_tb_file_nm;
	private List<String> img_cont;
	private String get_img_cont;
//	private List<Image> image_tb_list;
//	private List<Recipe_material> recipe_mt_list;
	//
	private List<String> rt_cont;
	private List<String> f_name;
	private String get_rt_cont;
	private String get_f_name;
	
	//레시피 추가 영양소 입력
	private long rn_idx;
	private List<String> nutrient_nm;
	private List<Long> rate;
	private String get_nutrient_nm;
	private long get_rate;
}
