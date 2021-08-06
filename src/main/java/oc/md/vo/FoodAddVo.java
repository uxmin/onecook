package oc.md.vo;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.javassist.bytecode.analysis.MultiArrayType;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import oc.md.domain.Food_detail;
import oc.md.domain.Food_explain;
import oc.md.domain.Image;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FoodAddVo {
	private String f_name;
	private String f_type;
	private long f_price;
	private long f_count;
	private String f_sales;
	private String f_weight;
	private String f_origin;
	private String f_package;
	private Date f_date;
	private String f_img;	//FOOD의 이미지 파일명칭
	private MultipartFile f_img_file;	//FOOD의 실제 이미지 파일
	
	private String fe_cont;
	
	private List<String> fd_sub;
	private List<String> fd_cont;
	
//	private List<Food_detail> food_detail_list;
//	private List<Food_explain> food_explain_list;
//	private List<MultipartFile> image_multipartfile;
//	private List<Image> image_list;
}
