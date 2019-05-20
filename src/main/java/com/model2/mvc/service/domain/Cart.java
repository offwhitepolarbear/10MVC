package com.model2.mvc.service.domain;

public class Cart {
	
	private String userId;
	private String productNames;
	private Product[] products;	
	
	public Cart() {
		
		// TODO Auto-generated constructor stub
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getProductNames() {
		return productNames;
	}

	public void setProductNames(String productNames) {
		this.productNames = productNames;
	}

	public Product[] getProducts() {
		return products;
	}

	public void setProducts(Product[] products) {
		this.products = products;
	}
	
}