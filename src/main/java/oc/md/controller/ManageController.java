package oc.md.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.log4j.Log4j;
import oc.md.domain.Delivery;
import oc.md.domain.Order_main;
import oc.md.domain.QNA;
import oc.md.domain.Stock_check;
import oc.md.domain.User_tb;
import oc.md.service.ManageService;
import oc.md.vo.PagingVO;
import oc.md.vo.SalesChkVO;

@Controller
@Log4j
@RequestMapping("/manage/*")
public class ManageController {
	@Autowired
	private ManageService mservice;
	
	// 1��1 ���� �ʱ� ������
	@RequestMapping("oneInquiry.do")
	public ModelAndView oneInquiryPage(PagingVO pagingVO, HttpSession session) {
		User_tb ut = (User_tb)session.getAttribute("loginUser");
		String email = ut.getEmail();
		
		List<QNA> qlist = mservice.selectInquiryPageS(pagingVO);
		long total = mservice.inquiryCountS();
		pagingVO.setTotal(total);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("manage/oneInquiry");
		mv.addObject("qlist", qlist);
		mv.addObject("p", pagingVO);
		
		return mv;
	}
	// 1��1 ���� �˻��Ǿ��� ������
	@PostMapping("one_cat_form.do")
	public ModelAndView oneCatFormPage(PagingVO pagingVO, String cat_nm, String cat_text) {
		log.info("###################### cat_nm : " + cat_nm + ", cat_text : " + cat_text);
		
		pagingVO.setCategory(cat_nm);
		pagingVO.setSort(cat_text);
		List<QNA> qlist = mservice.selectCategoryInquiryS(pagingVO);
		long total = mservice.inquiryCatCountS(pagingVO);
		pagingVO.setTotal(total);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("manage/oneInquiry");
		mv.addObject("qlist", qlist);
		mv.addObject("p", pagingVO);
		
		return mv;
	}
	
	// ����Ȯ�� ������(������ ���� ������)
	@RequestMapping("salesChart.do")
	public ModelAndView salesChart() {
		SalesChkVO tdypaycount  = mservice.todayPayCountS();
		SalesChkVO tdypayamount  = mservice.todayPayAmountS();
		SalesChkVO refund = mservice.userRefundCountS();
		SalesChkVO qna = mservice.qnaIsNullCountS();
		List<SalesChkVO> tlist = mservice.todayMostSalesS();
		List<SalesChkVO> tmlist = mservice.thsMonthMostSalesS();
		long today_allpay = mservice.todayAllPaymentS();
		List<SalesChkVO> etc = mservice.etcFoodS();
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("manage/salesChart");
//		mv.setViewName("manage/test");
//		mv.setViewName("manage/dashboard");
		mv.addObject("tdypaycount", tdypaycount);
		mv.addObject("tdypayamount", tdypayamount);
		mv.addObject("refund", refund);
		mv.addObject("qna", qna);
		mv.addObject("etc", etc);
		mv.addObject("tlist", tlist);
		mv.addObject("tmlist", tmlist);
		mv.addObject("today_allpay", today_allpay);
		
		return mv;
	}
	//���� ���Ϻ� Ư�� ���� �������� �� Ȯ��(where ���� Ư�� ���� �Է�)
	@PostMapping("varMonthChart")
	public @ResponseBody List<SalesChkVO> varMonthChart(String vardate){
		log.info("#################### vardate : " + vardate);
		List<SalesChkVO> vmlist = mservice.vartMonthMostSalesS(vardate);
		List<SalesChkVO> vdplist = mservice.varDatePaymentMostSalesS(vardate);
		for(int i =0; i<vmlist.size(); i++) {
			log.info("################ �߰��� " + i + " : " + vmlist.get(i));
			vmlist.get(i).setSum_price(vdplist.get(i).getSum_price());
		}
		for(int i =0; i<vmlist.size(); i++) {
			log.info("################ �߰��� " + i + " : " + vmlist.get(i));
		}
		
		
		return vmlist;
	}

	//Ư�� ���� ���� �ݾ� Ȯ���ϱ�(where ���� Ư�� ���� �Է�)
	@PostMapping("varDatePayment")
	public @ResponseBody List<SalesChkVO> varDatePayment(String vardate){
		log.info("#################### vardate : " + vardate);
		List<SalesChkVO> vdplist = mservice.varDatePaymentMostSalesS(vardate);
		
		return vdplist;
	}
	//Ư��  �ְ� ���� �ݾ� Ȯ��
	@PostMapping("varWeekPayment")
	public @ResponseBody List<SalesChkVO> varWeekPayment(String vardate){
		log.info("#################### vardate : " + vardate);
		List<SalesChkVO> vw_amount_list = mservice.varWeekPaymentMostSalesS(vardate);
		List<SalesChkVO> vw_sales_list = mservice.varWeekMostSalesS(vardate);
		
		for(int i =0; i<vw_amount_list.size(); i++) {
			log.info("################ �߰��� " + i + " : " + vw_amount_list.get(i));
			vw_amount_list.get(i).setVarcount(vw_sales_list.get(i).getVarcount());
			log.info("################ �߰���" + i + " : " + vw_amount_list.get(i));
		}
		
		return vw_amount_list;
	}
	
	//���Ȯ��
	@RequestMapping("stock_check.do")
	public ModelAndView list(PagingVO pagingVO) {
		pagingVO.setListCnt(20);
		log.info("###########################3 pagingVO : " + pagingVO);
		List<Stock_check> list = mservice.selectByFood_stock_checkS(pagingVO);
		
		long totalCount = mservice.selectCountS();
		pagingVO.setTotal(totalCount);
		
		
		ModelAndView mv = new ModelAndView("manage/stock_check");
		mv.addObject("list", list);
		mv.addObject("p", pagingVO);
		return mv;
	}
	
	@RequestMapping("stock_check_asc_desc.do")
	public ModelAndView listAD(String gubun, PagingVO pagingVO) {
		pagingVO.setListCnt(20);
		log.info("###########################3 pagingVO : " + pagingVO);
		log.info("###########################3 gubun : " + gubun);
		List<Stock_check> list = null;
		
		if(gubun.equals("��������")) {
			log.info("##################################��������");
			list = mservice.selectByFood_stock_checkS_asc(pagingVO);
		}else if(gubun.equals("��������")) {
			log.info("##################################��������");
			list = mservice.selectByFood_stock_checkS_desc(pagingVO);
		}
		long totalCount = mservice.selectCountS();
		pagingVO.setTotal(totalCount);
		
		ModelAndView mv = new ModelAndView("manage/stock_check");
		mv.addObject("list", list);
		mv.addObject("gubun", gubun);
		mv.addObject("p", pagingVO);
		return mv;
	}
	
	// �ֹ� ���� Ȯ�� �� ����
	@RequestMapping("order_check.do")
	public ModelAndView orderList(PagingVO pagingVO) {
		List<Order_main> list = mservice.orderListS(pagingVO);
		long total = mservice.countS();
		pagingVO.setTotal(total);

		ModelAndView mv = new ModelAndView("manage/order_check");
		mv.addObject("list", list);
		mv.addObject("p", pagingVO);
		
		return mv;
	}
	
	@RequestMapping("order_check_select.do")
	public ModelAndView orderListSelect(PagingVO pagingVO) {
//		System.out.println("###"+pagingVO.getSelect());
		
		List<Order_main> list = mservice.orderListSelectS(pagingVO);
		long total = mservice.countSelectS(pagingVO.getSelect());
		pagingVO.setTotal(total);
		
		ModelAndView mv = new ModelAndView("manage/order_check");
		mv.addObject("list", list);
		mv.addObject("p", pagingVO);
		
		return mv;
	}
	
	@ResponseBody
	@GetMapping("order_check_delivery.do")
	public String orderDelivery(Delivery delivery) {
		mservice.updateDeliveryS(delivery);
		//������ ��۹�ȣ VIEW�� �Ѱ��ֱ�
		return String.valueOf(delivery.getDelivery_num());
	}
	
	@ResponseBody
	@GetMapping("order_check_refund.do")
	public boolean orderRefund(long delivery_idx) {
		mservice.updateRefundS(delivery_idx);
		return true;
	}
}
