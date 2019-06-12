package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.User;

public class UserDAO {
	public UserDAO(){
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() throws SQLException{
		return DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306"
				+ "/music?characterEncoding=UTF-8","root","root");
	}
	
	public int getTotal(){
		int total = 0;
		try(Connection c = getConnection(); Statement s = c.createStatement()) {
			String sql = "select count(*) from user";
			ResultSet rs =s.executeQuery(sql);
			if(rs.next()){
				total = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return total;
	}
	
	public User getUser(String account, String password){
		User user = null;

		String sql = "select * from user where account = ? and password = ?";

		try(Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql);){
			ps.setString(1, account);
			ps.setString(2, password);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				user = new User();
				user.setAccount(rs.getString(1));
				user.setPassword(rs.getString(2));
				user.setState(rs.getString(3));
				user.setNickname(rs.getString(4));
				user.setGender(rs.getString(5));
				user.setBirthday(rs.getString(6));
			}

		} catch(Exception e){
			e.printStackTrace();
		}

		return user;
	}
	
	public void add(User user){
		String sql = "insert into user values(?, ?, '0', ?, ?, ?)";
		try(Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setString(1, user.getAccount());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getNickname());
			ps.setString(4, user.getGender());
			ps.setString(5, user.getBirthday());
			
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void delete(String account){
		try(Connection c = getConnection();Statement s = c.createStatement();) {
			String sql = "delete from user where account = '" + account + "'";
			
			s.execute(sql);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	}
	
	public void update(User user){
		String sql = "update user set password = ?, nickname = ?, gender = ?, birthday = ? where account = ?";
		try(Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setString(1, user.getPassword());
			ps.setString(2, user.getNickname());
			ps.setString(3, user.getGender());
			ps.setString(4, user.getBirthday());
			ps.setString(5, user.getAccount());
			
			ps.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public List<User> list(){
		return list(0, Short.MAX_VALUE);
	}
	
	public List<User> list(int start, int count){  //获得用户链表（剔除管理员）
		List<User> users = new ArrayList<User>();
		
		String sql = "select * from user where state = '0' limit ?,? ";
		
		try(Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			
			ps.setInt(1, start);
			ps.setInt(2, count);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				User user = new User();
				user.setAccount(rs.getString(1));
				user.setPassword(rs.getString(2));
				user.setState(rs.getString(3));
				user.setNickname(rs.getString(4));
				user.setGender(rs.getString(5));
				user.setBirthday(rs.getString(6));
				
				users.add(user);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return users;
	}
}