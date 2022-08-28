package com.kh.campervalley.campsite.model.common;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.PostConstruct;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.kh.campervalley.campsite.model.dto.CampsiteExt;
import com.kh.campervalley.campsite.model.dto.CampsiteFacility;
import com.kh.campervalley.campsite.model.dto.CampsiteImage;
import com.kh.campervalley.campsite.model.service.CampsiteService;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
@PropertySource("classpath:datasource.properties")
public class CampsiteApiData {
	
	@Autowired
	private CampsiteService campsiteService;
	
	@PostConstruct
	public void campsiteApiServiceInit() {
		log.debug("[캠핑장 정보 갱신 : 매달 1일 오전 2시 실행]");
		log.debug("[캠핑장 이미지 정보 갱신 : 매달 1일 오전 2시 실행]");
	}

	@Value("${api.goCamping}")
	String SERVICE_KEY;
	
	final static String basedListURL = "https://api.visitkorea.or.kr/openapi/service/rest/GoCamping/basedList";
	final static String imageListURL = "https://api.visitkorea.or.kr/openapi/service/rest/GoCamping/imageList";
	
	@Scheduled(cron = "0 0 2 1 * ?")
	public void getCampsiteApiData() {
		ArrayList<HashMap<String, Object>> list = null;
		List<CampsiteExt> campsiteList = new ArrayList<>();
		
		try {
			StringBuilder urlBuilder = new StringBuilder(basedListURL);
			
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + SERVICE_KEY);
			urlBuilder.append("&" + URLEncoder.encode("MobileOS","UTF-8")+ "=" + URLEncoder.encode("ETC", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("MobileApp","UTF-8") + "=" + URLEncoder.encode("campervalley", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
			
			String url = urlBuilder.toString();
			ArrayList<String> urls = new ArrayList<>();
			urls.add(url);
			
			HashMap<String, String> headers = new HashMap<String, String>();
			headers.put("Content-type", "application/json");
			
			String jsonApi = CampsiteUtils.sendSeverMsg(urls, headers, "get");
			JSONObject jsonObject = CampsiteUtils.jsonStringToJson(jsonApi);
			JSONObject response = CampsiteUtils.jsonStringToJson(jsonObject.get("response"));
			JSONObject body = CampsiteUtils.jsonStringToJson(response.get("body"));
			int totalCount = (Integer) body.get("totalCount");
			
			StringBuilder updateUrlBuilder = new StringBuilder(basedListURL);
			
			updateUrlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + SERVICE_KEY);
			updateUrlBuilder.append("&" + URLEncoder.encode("MobileOS","UTF-8")+ "=" + URLEncoder.encode("ETC", "UTF-8"));
			updateUrlBuilder.append("&" + URLEncoder.encode("MobileApp","UTF-8") + "=" + URLEncoder.encode("campervalley", "UTF-8"));
			updateUrlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
			updateUrlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
			updateUrlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + totalCount);
			
			url = updateUrlBuilder.toString();
			urls = new ArrayList<String>();
			urls.add(url);
			
			headers = new HashMap<String, String>();
			headers.put("Content-type", "application/json");
			
			jsonApi = CampsiteUtils.sendSeverMsg(urls, headers, "get");
			jsonObject = CampsiteUtils.jsonStringToJson(jsonApi);
			response = CampsiteUtils.jsonStringToJson(jsonObject.get("response"));
			body = CampsiteUtils.jsonStringToJson(response.get("body"));
			JSONObject items = CampsiteUtils.jsonStringToJson(body.get("items"));
			list = CampsiteUtils.jsonArray(items.get("item"));
			
			for(int i = 0; i < list.size(); i++) {
				HashMap<String, Object> item = list.get(i);
				
				long contentId = Long.parseLong(String.valueOf(item.get("contentId")));
				String facltNm = (String) item.get("facltNm");
				String lineIntro = (String) item.get("lineIntro");
				String intro = (String) item.get("intro");
				String facltDivNm = (String) item.get("facltDivNm");
				String induty = (String) item.get("induty");
				String lctCl = (String) item.get("lctCl");
				String addr1 = (String) item.get("addr1");
				String addr2 = (String) item.get("addr2");
				String mapX = (String) item.get("mapX");
				String mapY = (String) item.get("mapY");
				String tel = (String) item.get("tel");
				String homepage = (String) item.get("homepage");
				String resveCl = (String) item.get("resveCl");
				String operPdCl = (String) item.get("operPdCl");
				String operDeCl = (String) item.get("operDeCl");
				String posblFcltyCl = (String) item.get("posblFcltyCl");
				String themaEnvrnCl = (String) item.get("themaEnvrnCl");
				String firstImageUrl = (String) item.get("firstImageUrl");
				
				CampsiteExt campsite = 
						new CampsiteExt(
								contentId, facltNm, lineIntro, intro, facltDivNm, 
								induty, lctCl, addr1, addr2, mapX, mapY, tel, homepage, 
								resveCl, operPdCl, operDeCl, posblFcltyCl, 
								themaEnvrnCl, firstImageUrl);
				
				int gnrlSiteCo = Integer.parseInt(String.valueOf(item.get("gnrlSiteCo")));
				int autoSiteCo = Integer.parseInt(String.valueOf(item.get("autoSiteCo")));
				int glampSiteCo = Integer.parseInt(String.valueOf(item.get("glampSiteCo")));
				int caravSiteCo = Integer.parseInt(String.valueOf(item.get("caravSiteCo")));
				int indvdlCaravSiteCo = Integer.parseInt(String.valueOf(item.get("indvdlCaravSiteCo")));
				int siteMg1Width = Integer.parseInt(String.valueOf(item.get("siteMg1Width")));
				int siteMg2Width = Integer.parseInt(String.valueOf(item.get("siteMg2Width")));
				int siteMg3Width = Integer.parseInt(String.valueOf(item.get("siteMg3Width")));
				int siteMg1Vrticl = Integer.parseInt(String.valueOf(item.get("siteMg1Vrticl")));
				int siteMg2Vrticl = Integer.parseInt(String.valueOf(item.get("siteMg2Vrticl")));
				int siteMg3Vrticl = Integer.parseInt(String.valueOf(item.get("siteMg3Vrticl")));
				int siteMg1Co = Integer.parseInt(String.valueOf(item.get("siteMg1Co")));
				int siteMg2Co = Integer.parseInt(String.valueOf(item.get("siteMg2Co")));
				int siteMg3Co = Integer.parseInt(String.valueOf(item.get("siteMg3Co")));
				int siteBottomCl1 = Integer.parseInt(String.valueOf(item.get("siteBottomCl1")));
				int siteBottomCl2 = Integer.parseInt(String.valueOf(item.get("siteBottomCl2")));
				int siteBottomCl3 = Integer.parseInt(String.valueOf(item.get("siteBottomCl3")));
				int siteBottomCl4 = Integer.parseInt(String.valueOf(item.get("siteBottomCl4")));
				int siteBottomCl5 = Integer.parseInt(String.valueOf(item.get("siteBottomCl5")));
				String glampInnerFclty = (String) item.get("glampInnerFclty");
				String caravInnerFclty = (String) item.get("caravInnerFclty");
				String trlerAcmpnyAt = (String) item.get("trlerAcmpnyAt");
				String caravAcmpnyAt = (String) item.get("caravAcmpnyAt");
				int toiletCo = Integer.parseInt(String.valueOf(item.get("toiletCo")));
				int swrmCo = Integer.parseInt(String.valueOf(item.get("swrmCo")));
				int wtrplCo = Integer.parseInt(String.valueOf(item.get("wtrplCo")));
				String brazierCl = (String) item.get("brazierCl");
				String sbrsCl = (String) item.get("sbrsCl");
				String sbrsEtc = (String) item.get("sbrsEtc");
				int extshrCo = Integer.parseInt(String.valueOf(item.get("extshrCo")));
				int frprvtWrppCo = Integer.parseInt(String.valueOf(item.get("frprvtWrppCo")));
				int frprvtSandCo = Integer.parseInt(String.valueOf(item.get("frprvtSandCo")));
				String eqpmnLendCl = (String) item.get("eqpmnLendCl");
				String animalCmgCl = (String) item.get("animalCmgCl");
				
				CampsiteFacility campsiteFacility = 
						new CampsiteFacility(
								contentId, gnrlSiteCo, autoSiteCo, 
								glampSiteCo, caravSiteCo, indvdlCaravSiteCo, 
								siteMg1Width, siteMg2Width, siteMg3Width, 
								siteMg1Vrticl, siteMg2Vrticl, siteMg3Vrticl, 
								siteMg1Co, siteMg2Co, siteMg3Co, 
								siteBottomCl1, siteBottomCl2, siteBottomCl3, siteBottomCl4, siteBottomCl5, 
								glampInnerFclty, caravInnerFclty, trlerAcmpnyAt, caravAcmpnyAt, 
								toiletCo, swrmCo, wtrplCo, brazierCl, sbrsCl, sbrsEtc, extshrCo, 
								frprvtWrppCo, frprvtSandCo, eqpmnLendCl, animalCmgCl);
				campsite.setCampsiteFacility(campsiteFacility);
				campsite.addCampsiteFacility(campsiteFacility);
				campsiteList.add(campsite);

				int result = campsiteService.insertCampsiteList(campsiteList);
			}
		} catch (JSONException | IOException e) {
			e.printStackTrace();
		}
	}
	
	@Scheduled(cron = "0 0 2 1 * ?")
	public void getCampsiteImageApiData() {
		List<CampsiteExt> contentIdList = campsiteService.selectContentIdList();
		for(int i = 0; i < contentIdList.size(); i++) {
			long contentId = contentIdList.get(i).getContentId();
			List<CampsiteImage> campsiteImageList;
			try {
				campsiteImageList = campsiteImageParsingData(contentId);
				for(CampsiteImage campsiteImage : campsiteImageList) {
					int result = campsiteService.insertCampsiteImage(campsiteImage);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
		
	public List<CampsiteImage> campsiteImageParsingData(long contentId) throws Exception {
		List <CampsiteImage> campsiteImageList = new ArrayList<>();
        
        JSONParser jsonParser = new JSONParser();
        org.json.simple.JSONObject jsonObject = (org.json.simple.JSONObject) jsonParser.parse(readUrl(contentId));
        org.json.simple.JSONObject response = (org.json.simple.JSONObject) jsonObject.get("response"); 
        org.json.simple.JSONObject body = (org.json.simple.JSONObject) response.get("body");
        org.json.simple.JSONObject items = (org.json.simple.JSONObject) body.get("items");
        JSONArray item = (JSONArray) items.get("item");
        org.json.simple.JSONObject campsite;
        
        for(int i = 0 ; i < item.size(); i++) {
        	campsite = (org.json.simple.JSONObject) item.get(i);
        	CampsiteImage campsiteImage = new CampsiteImage();
        	campsiteImage.setSerialnum(Long.parseLong((String) campsite.get("serialnum")));
        	campsiteImage.setContentId(Long.parseLong((String) campsite.get("contentId")));
        	campsiteImage.setImageUrl((String) campsite.get("imageUrl"));
        	campsiteImageList.add(campsiteImage);
        }
        return campsiteImageList;
	}
	
	public String readUrl(long contentId) throws Exception {
		BufferedInputStream reader = null;
        
		try {
			StringBuilder imgUrlBuilder = new StringBuilder(imageListURL);
			
			imgUrlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + SERVICE_KEY);
			imgUrlBuilder.append("&" + URLEncoder.encode("MobileOS","UTF-8")+ "=" + URLEncoder.encode("ETC", "UTF-8"));
			imgUrlBuilder.append("&" + URLEncoder.encode("MobileApp","UTF-8") + "=" + URLEncoder.encode("campervalley", "UTF-8"));
			imgUrlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
			imgUrlBuilder.append("&" + URLEncoder.encode("contentId","UTF-8") + "=" + contentId);
			
			String addr = imgUrlBuilder.toString();
            URL url = new URL(addr);
            
            reader = new BufferedInputStream(url.openStream());
            StringBuffer buffer = new StringBuffer();
            int i;
            byte[] b = new byte[4096];
            while((i = reader.read(b)) != -1) {
            	buffer.append(new String(b, 0, i));
            }
            return buffer.toString();
		} finally {
			if(reader != null)
				reader.close();
		}
	}

//	public List<CampsiteImage> getCampsiteImageApiData(long contentId) {
//		ArrayList<HashMap<String, Object>> list = null;
//		List<CampsiteImage> campsiteImageList = new ArrayList<>();
//		
//		try {
//			StringBuilder imgUrlBuilder = new StringBuilder(imageListURL);
//			
//			imgUrlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + SERVICE_KEY);
//			imgUrlBuilder.append("&" + URLEncoder.encode("MobileOS","UTF-8")+ "=" + URLEncoder.encode("ETC", "UTF-8"));
//			imgUrlBuilder.append("&" + URLEncoder.encode("MobileApp","UTF-8") + "=" + URLEncoder.encode("campervalley", "UTF-8"));
//			imgUrlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
//			imgUrlBuilder.append("&" + URLEncoder.encode("contentId","UTF-8") + "=" + contentId);
//			
//			String url = imgUrlBuilder.toString();
//			ArrayList<String> urls = new ArrayList<>();
//			urls.add(url);
//			
//			HashMap<String, String> headers = new HashMap<String, String>();
//			headers.put("Content-type", "application/json");
//			
//			String jsonApi = CampsiteUtils.sendSeverMsg(urls, headers, "get");
//			JSONObject jsonObject = CampsiteUtils.jsonStringToJson(jsonApi);
//			JSONObject response = CampsiteUtils.jsonStringToJson(jsonObject.get("response"));
//			JSONObject body = CampsiteUtils.jsonStringToJson(response.get("body"));
//			JSONObject items = CampsiteUtils.jsonStringToJson(body.get("items"));
//			list = CampsiteUtils.jsonArray(items.get("item"));
//			
//			for(int i = 0; i < list.size(); i++) {
//				HashMap<String, Object> item = list.get(i);
//				
//				long serialnum = Long.parseLong(String.valueOf(item.get("serialnum")));
//				contentId = Long.parseLong(String.valueOf(item.get("contentId")));
//				String imageUrl = (String) item.get("imageUrl");
//				
//				CampsiteImage campsiteImage = new CampsiteImage(serialnum, contentId, imageUrl);					
//				campsiteImageList.add(campsiteImage);
//			}
//			
//		} catch (JSONException | IOException e) {
//			e.printStackTrace();
//		}
//		
//		return campsiteImageList;
//	}
	
}
