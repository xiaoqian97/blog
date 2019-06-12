package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.Song;
import bean.User;

public class SongDAO {
	public SongDAO(){
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
			String sql = "select count(*) from song";
			ResultSet rs =s.executeQuery(sql);
			if(rs.next()){
				total = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return total;
	}

//获得具体用户的歌曲数
	public int getTotal(User account){
		int total = 0;
		try(Connection c = getConnection(); Statement s = c.createStatement()) {
			String sql = "select count(*) from song where account = '" + account.getAccount() + "'";
			ResultSet rs =s.executeQuery(sql);
			if(rs.next()){
				total = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return total;
	}
	
	public void add(Song song){
		String sql = "insert into song values(null, ?, ?, ?, ?, ?)";
		try(Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setString(1, song.getName());
			ps.setString(2, song.getFilesize());
			ps.setString(3, song.getSinger());
			ps.setString(4, song.getPath());
			ps.setString(5, song.getAccount().getAccount());

			ps.execute();

			ResultSet rs = ps.getGeneratedKeys();
			if(rs.next()){
				int id = rs.getInt(1);
				song.setId(id);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void delete(int id){
		try(Connection c = getConnection();Statement s = c.createStatement();) {
			String sql = "delete from song where id = " + id;

			s.execute(sql);

		} catch (SQLException e) {
			e.printStackTrace();
		} 
	}

	//使用用户获得歌曲链表
	public List<Song> list(User account){
		return list(0, Short.MAX_VALUE, account);
	}

	public List<Song> list(int start, int count, User account){
		List<Song> songs = new ArrayList<Song>();

		//传递用户名account.geAccount()
		String sql = "select * from song where account = '" + account.getAccount() + "'" + " limit ?,? ";

		try(Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {

			ps.setInt(1, start);
			ps.setInt(2, count);

			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				Song song = new Song();
				song.setId(rs.getInt(1));
				song.setName(rs.getString(2));
				song.setFilesize(rs.getString(3));
				song.setSinger(rs.getString(4));
				song.setPath(rs.getString(5));
				song.setAccount(account);

				songs.add(song);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return songs;
	}

	//不使用用户获得歌曲链表
	public List<Song> list(){
		return list(0, Short.MAX_VALUE);
	}

	public List<Song> list(int start, int count){
		List<Song> songs = new ArrayList<Song>();

		String sql = "select * from song limit ?,? ";

		try(Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {

			ps.setInt(1, start);
			ps.setInt(2, count);

			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				User account = new User();
				Song song = new Song();
				song.setId(rs.getInt(1));
				song.setName(rs.getString(2));
				song.setFilesize(rs.getString(3));
				song.setSinger(rs.getString(4));
				song.setPath(rs.getString(5));
				song.setAccount(account);

				songs.add(song);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return songs;
	}

//获得歌名链表，用于搜索框
	public List<String> songnameList(){
		List<String> songnames = new ArrayList<String>();

		try(Connection c = getConnection(); Statement s = c.createStatement()) {
			String sql = "select name from song";
			
			ResultSet rs = s.executeQuery(sql);
			while(rs.next()){
				String songname = rs.getString(1);
				
				songnames.add(songname);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return songnames;
	}	
}
