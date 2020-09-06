package com.redsocial.web.app.Services;


import com.redsocial.web.app.Models.User;

public interface IUserService {
	
	public void createUser (User user) throws Exception;
	public void updateUser (User user);
	public void deleteUser (Integer idUser);
	
}
