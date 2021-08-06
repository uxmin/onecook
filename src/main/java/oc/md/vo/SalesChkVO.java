package oc.md.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SalesChkVO {
	private long today_paycount;	//´çÀÏ±âÁØ ÆÇ¸Å È½¼ö ÆÄ¾Ç
	private String f_name;
	private long sales_fcount;
	private String thsdate;
	private long thscount;
	private String vardate;
	private long varcount;
	private long sum_price;	//ÃÑ °¡°Ý	
}
