package com.tripPocket.www.tripEvent.dto;

public class RegionDTO {
	private String name;
    private int code;
    
    public RegionDTO(String name, int code) {
    	this.name = name;
        this.code = code;
	}
    
	public String getName() {
		return name;
	}
	public int getCode() {
		return code;
	}
   
}
