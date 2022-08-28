package com.kh.campervalley.campsite.model.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

import org.json.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CampsiteUtils {

	public static String sendSeverMsg (
			ArrayList<String> urls, 
			HashMap<String, String> header, 
			String method) {
		
		String result = "";
		StringBuffer sb = new StringBuffer();
		HttpURLConnection conn = null;
		BufferedReader br = null;
		
		for (String url : urls)
			sb.append(url);
		
		try {
			URL url = new URL(sb.toString());
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod(method.toUpperCase());
			conn.setDoOutput(true);
			
			if(header != null && header.size() > 0) {
				for(String key : header.keySet())
					conn.setRequestProperty(key, header.get(key));
			}
			
			int responseCode = conn.getResponseCode();
			if(responseCode >= 200 && responseCode <= 300) {
			    br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
			    br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			
			String readLine = "";
			sb = new StringBuffer();
			while ((readLine = br.readLine()) != null) {
				sb.append(readLine);
			}
			
			result = sb.toString();
			
			if(responseCode != 200)
				result = "Fail Message : " + result;
			
		} catch (Exception e) {
			result = "Fail Message : " + e.toString();
		} finally {
			try {
				if(br != null) br.close();
				if(conn != null) conn.disconnect();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public static JSONObject jsonStringToJson(Object result) {
		JSONObject jsonObject = null;
		try {
			jsonObject = new JSONObject(result.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObject;
	}
	
	public static ArrayList<HashMap<String,Object>> jsonArray(Object result) {
		org.json.simple.JSONArray jsonArr = null;
		org.json.simple.JSONObject jsonObject = null;
		HashMap<String,Object> map = null;
		ArrayList<HashMap<String,Object>> arr = new ArrayList<HashMap<String,Object>>();
			try {
				jsonArr = (JSONArray) new JSONParser().parse(result.toString());
				for (int i = 0; i < jsonArr.size(); i++) {
					jsonObject = (org.json.simple.JSONObject) jsonArr.get( i );
					map = new ObjectMapper().readValue(jsonObject.toString(), HashMap.class);
					arr.add(map);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		return arr;
	}
	
}
