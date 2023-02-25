import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;

import javax.xml.xquery.XQConnection;
import javax.xml.xquery.XQDataSource;
import javax.xml.xquery.XQException;
import javax.xml.xquery.XQPreparedExpression;
import javax.xml.xquery.XQResultSequence;

import com.saxonica.xqj.SaxonXQDataSource;

public class Main
{
	public static void main(String[] args)
	{
		try
		{
			InputStream inputStream = Files.newInputStream(new File("pelicules.xqy").toPath());
			XQDataSource ds = new SaxonXQDataSource();
			XQConnection conn = ds.getConnection();
			XQPreparedExpression exp = conn.prepareExpression(inputStream);
			XQResultSequence result = exp.executeQuery();
			String xquery = "";
			while(result.next())
			{
//				System.out.println(result.getItemAsString(null));
				xquery = result.getItemAsString(null);
			}
			PrintWriter out = new PrintWriter("output.html");
			out.println(xquery);
			out.flush();
			out.close();
		}
		catch(XQException | IOException e)
		{
			e.printStackTrace();
		}
	}
}