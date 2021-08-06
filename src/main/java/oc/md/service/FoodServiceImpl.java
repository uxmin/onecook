package oc.md.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import oc.md.domain.Cart;
import oc.md.domain.Food;
import oc.md.domain.Food_detail;
import oc.md.domain.Food_explain;
import oc.md.domain.OrderList;
import oc.md.domain.Postscript;
import oc.md.domain.QNA;
import oc.md.domain.Review;
import oc.md.filesetting.Path;
import oc.md.mapper.FoodMapper;
import oc.md.vo.FoodAddVo;
import oc.md.vo.FoodPagingVO;
import oc.md.vo.PagingVO;
import oc.md.vo.PagingVO2;

@Service
@Log4j
public class FoodServiceImpl implements FoodService {
	@Autowired
	private FoodMapper fmapper;
	
	//��� ���
	@Override
	@Transactional
	public boolean FoodAddS(FoodAddVo foodAddVo) {
		MultipartFile f = foodAddVo.getF_img_file();
		String gubun = "foodAdd";	//�̹��� ���ε� ������ ���� ��Ī
		System.out.println("###################### f :" + f);
		
		String FoodImgFileName = saveStore(f, gubun, foodAddVo.getF_type());
		foodAddVo.setF_img(FoodImgFileName);
		System.out.println("###################### FoodImgFileName :" + FoodImgFileName);
		System.out.println("###################### foodAddVo Set result :" + foodAddVo);
		
		boolean foodFlag = fmapper.FoodInsert(foodAddVo);
		System.out.println("###################### foodFlag : " + foodFlag);
		System.out.println("###################### foodAddVo : " + foodAddVo.getF_name());
		
		if(foodFlag) {
			boolean foodExplainFlag = fmapper.FoodExplainInsert(foodAddVo);
		
			if(foodExplainFlag) {
				for(int i=0; i<foodAddVo.getFd_sub().size(); i++) {
					System.out.println("###################### i : " + i);
					String fd_f_name = foodAddVo.getF_name();
					String fd_fd_sub = foodAddVo.getFd_sub().get(i);
					String fd_fd_cont = foodAddVo.getFd_cont().get(i);
					fmapper.FoodDetailInsert(fd_f_name, fd_fd_sub, fd_fd_cont);
				}
				
				return true;
			}
			else {
				return false;
			}
		}
		else {
			return false;
		}
		
	}
	//��� ���� �̹����� ����
	public String saveStore(MultipartFile f, String gubun, String type) {
		// TODO Auto-generated method stub
		String ofname = f.getOriginalFilename();
		int idx = ofname.lastIndexOf(".");
		String ofheader = ofname.substring(0, idx);
		String ext = ofname.substring(idx);
		long ms = System.currentTimeMillis();
		StringBuilder sb = new StringBuilder();
		sb.append(ofheader);
		sb.append("_");
		sb.append(ms);
		sb.append(ext);
		String saveFileName = sb.toString();
		long fsize = f.getSize();
		
		System.out.println("ofname : " + ofname + ", fname : " + saveFileName + ", fsize : " + fsize);
		
		boolean flag = writeFile(f, saveFileName, gubun, type);
		if(flag) {
			log.info("���ε� ����");
		}else {
			log.info("���ε� ����");
		}
		return saveFileName;
	}
	
	// ��� ���� �̹��� ���� ���ε�
	public boolean writeFile(MultipartFile f, String saveFileName, String gubun, String type) {	
		//�������̽� �޼ҵ�� ������ public��
		String path = "";
		if(gubun.equals("foodAdd")) {
			path = Path.FOOD_PATH + type + "/";
		}
		else if(gubun.equals("postScriptAdd")){
			path = Path.FOOD_POSTSCRIPT_PATH;
		}
		File dir = new File(path);
		
		if(!dir.exists()) dir.mkdirs();
		
		FileOutputStream fos = null;
		try {
			byte data[] = f.getBytes();
			fos = new FileOutputStream(path + saveFileName);
			fos.write(data);
			fos.flush();
			
			return true;
		}
		catch(IOException ie) {
			return false;
		}
		finally {
			try {
				fos.close();
			}
			catch(IOException ie) {}
		}
	}
	
	@Override
	public List<Food> pageS(FoodPagingVO foodPagingVO) {
		return fmapper.page(foodPagingVO);
	}
	@Override
	public long countS() {
		return fmapper.count();
	}
	
	@Override
	public List<Food> categoryPageS(FoodPagingVO foodPagingVO){
		return fmapper.categoryPage(foodPagingVO);
	}
	@Override
	public long categoryCountS(String category) {
		return fmapper.categoryCount(category);
	}
	@Override
	public List<Food> searchPageS(FoodPagingVO foodPagingVO){
		return fmapper.searchPage(foodPagingVO);
	}
	@Override
	public long searchCountS(String f_name) {
		return fmapper.searchCount(f_name);
	}
	
	
	@Override
	public List<Food> priceHighPageS(FoodPagingVO foodPagingVO) {
		return fmapper.priceHighPage(foodPagingVO);
	}
	@Override
	public List<Food> priceLowPageS(FoodPagingVO foodPagingVO) {
		return fmapper.priceLowPage(foodPagingVO);
	}
	
	
	@Override
	public Food readS(String f_name){
		return fmapper.read(f_name);
	}
	//�ִ� ����Ǹ� Ȯ�� 
	@Override
	public List<OrderList> bestFoodSelectS(){
		return fmapper.bestFoodSelect();
	}
	@Override
	public 	long reviewCountS(String f_name) {
		return fmapper.reviewCount(f_name);
	}
	@Override
	public long averageStarCountS(String f_name) {
		return fmapper.averageStarCount(f_name);
	}
	//�ı��ۼ� ����
	@Override
	public Postscript checkPostscriptS(Postscript script) {
		return fmapper.checkPostscript(script);
	}
	@Override
	public List<QNA> pageQNAS(PagingVO pagingVO){
		return fmapper.pageQNA(pagingVO);
	}
	@Override
	public long countQNAS(PagingVO pagingVO) {
		return fmapper.countQNA(pagingVO);
	}
	@Override
	public boolean updateQNAS(QNA qna) {
		return fmapper.updateQNA(qna);
	}
	@Override
	public void insertQNAS(QNA qna) {
		fmapper.insertQNA(qna);
	}
	//�ı� ����Ʈ
	@Override
	public List<Review> postScriptSelectPerPageS(PagingVO2 pagingVO2) {
		List<Review> list = fmapper.postScriptSelectPerPage(pagingVO2);
		System.out.println("#############@@@# pagingVO2 serviceimpl : " + pagingVO2);
		System.out.println("#############@@@# list serviceimpl : " + list);
		return list;
	}

	@Override
	public long postScriptSelectCountS(String f_name) {
		return fmapper.postScriptSelectCount(f_name);
	}
	
	@Override
	@Transactional
	public void postScriptInsertS(Review review, String order_idx) {
		Review review2 = null;
		String gubun = "postScriptAdd";	//�̹������ε� ������ ���� ��Ī
		
		HashMap<String, Object> hs = new HashMap<String, Object>();
		hs.put("order_idx", order_idx);
		hs.put("f_name", review.getF_name());
		
		if(review.getRv_img_file().getOriginalFilename() == null) {
			log.info("#>True");
		}
		log.info("#>"+review.getRv_img_file().getOriginalFilename());
		if(!review.getRv_img_file().getOriginalFilename().trim().equals("")) {
			String ofname = saveStore(review.getRv_img_file(), gubun, null);
			review2 = new Review(-1L, review.getEmail(), review.getF_name(), review.getRv_date(), review.getRv_cont(), review.getRv_sub(), null, ofname, review.getRv_num(), review.getUser_name(), review.getStar());
			fmapper.postScriptInsertImage(review2);
			//�ı� �ۼ� �Ϸ�� �ı� �ۼ� ���� 1�� ������Ʈ
			fmapper.postScriptExistUpdate(hs);
			//�ı� �ۼ��� �̹����� �������� ������ �ش� ������ ����Ʈ�� 50��ŭ ����
			fmapper.noImageUserPoint(review.getEmail());

		}else {
			review2 = new Review(-1L, review.getEmail(), review.getF_name(), review.getRv_date(), review.getRv_cont(), review.getRv_sub(), null, null, review.getRv_num(), review.getUser_name(), review.getStar());	
			fmapper.postScriptInsertNoimage(review2);
			//�ı� �ۼ� �Ϸ�� �ı� �ۼ� ���� 1�� ������Ʈ
			fmapper.postScriptExistUpdate(hs);
			//�ı� �ۼ��� �̹����� �����ϸ� �ش� ������ ����Ʈ�� 200��ŭ ����
			fmapper.imageUserPoint(review.getEmail());

		}
	}
	@Override
	public Review postScriptSelectBySeqS(long rv_idx) {
		return fmapper.postScriptSelectBySeq(rv_idx);
	}
	@Override
	public void postScriptCountUpdateS(Review review) {
		fmapper.postScriptCountUpdate(review);
	}
	@Override
	public List<Food_detail> selectByFood_detailS(String f_name) {
		List<Food_detail> list = fmapper.selectByFood_detail(f_name);
		return list;
	}
	@Override
	public List<Food_explain> explainReadS(String f_name) {
		return fmapper.explainRead(f_name);
	}
	// ��� ���� ����Ʈ���� ��� ���� Ȯ��
	@Override
	public String existFnameSelectS(Cart ct) {
		return fmapper.existFnameSelect(ct);
	}
	@Override
	public boolean updateCartCountS(Cart ct) {
		return fmapper.updateCartCount(ct);
	}
	@Override
	public boolean insertCartCountS(Cart ct) {
		return fmapper.insertCartCount(ct);
	}
	@Override
	public void postscriptDeleteS(Review review) {
		fmapper.postscriptDelete(review);
	}
	@Override
	public void qnaDeleteS(QNA qna) {
		fmapper.qnaDelete(qna);
	}
}
