package com.kh.util;

import java.io.OutputStream;
import java.util.List;

import jxl.Workbook;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

public class ToExcel {
	/**
	 * 导出业务逻辑 gcl 20111019
	 * 
	 * @param tlist
	 *            要显示到excel表格中的标题
	 * @param list
	 *            要显示到excel表格中的集合
	 * @param os
	 *            输出流
	 * @param filename
	 *            要保存成的文件名
	 * @param list2
	 *            合计 集合
	 * @return
	 */
	public static void exportExcel(String[] tlist, List list,
			String filename, OutputStream os,List list2) {
		try {
			WritableWorkbook book=Workbook.createWorkbook(os);
			// 生成名为 ttype 的工作表，参数0表示这是第一页
			WritableSheet sheet = book.createSheet("表格1", 0);
			jxl.write.WritableFont menuStyle = new jxl.write.WritableFont(
					WritableFont.ARIAL, 13, WritableFont.BOLD, false,
					UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLACK);
			jxl.write.WritableCellFormat menu = new jxl.write.WritableCellFormat(
					menuStyle);
			// 设置表头
			for (short i = 0; i < tlist.length; i++) {
				String text= tlist[i];
				Label label = new Label(i, 0, " "+text+"  ",menu);
				// 将定义好的单元格添加到工作表中
				sheet.addCell(label);
				sheet.setColumnView(i, 20);
			}
			int len = list.size();
			for (int i = 0; i < len; i++) {
				if (i < 65534) {
					List cell = (List) list.get(i);
					for (int j = 0; j < cell.size(); j++) {
						Label label = new Label(j, i + 1, cell.get(j) == null ? ""
								: cell.get(j).toString());
						// 将定义好的单元格添加到工作表中
						sheet.addCell(label);
					}
				}
			}
			// 加入合计
			if (list2 != null && list2.size() > 0) {
				Label label1 = new Label(0, len + 1,"合计：");
				Label label2 = new Label(1, len + 1,"");
				sheet.addCell(label1);
				sheet.addCell(label2);
				for (int i = 0; i < list2.size(); i++) {
					List cell = (List) list2.get(i);
					for (int j = 0; j < cell.size(); j++) {
						Label label = new Label(j+2, len + 1 + i,
								cell.get(j) == null ? "" : cell.get(j).toString());
						// 将定义好的单元格添加到工作表中
						sheet.addCell(label);
					}
				}
			}
			// 写入数据
			book.write();
			// 写入数据并关闭文件
			book.close();
			os.flush();
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static void exportExcel2(String[] tlist, List list,
			String filename, OutputStream os,List list2) {
		try {
			WritableWorkbook book=Workbook.createWorkbook(os);
			// 生成名为 ttype 的工作表，参数0表示这是第一页
			WritableSheet sheet = book.createSheet("表格1", 0);
			jxl.write.WritableFont menuStyle = new jxl.write.WritableFont(
					WritableFont.ARIAL, 13, WritableFont.BOLD, false,
					UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLACK);
			jxl.write.WritableCellFormat menu = new jxl.write.WritableCellFormat(
					menuStyle);
			// 设置表头
			for (short i = 0; i < tlist.length; i++) {
				String text= tlist[i];
				Label label = new Label(i, 0, " "+text+"  ",menu);
				// 将定义好的单元格添加到工作表中
				sheet.addCell(label);
				sheet.setColumnView(i, 20);
			}
			int len = list.size();
			for (int i = 0; i < len; i++) {
				if (i < 65534) {
					List cell = (List) list.get(i);
					for (int j = 0; j < cell.size(); j++) {
						Label label = new Label(j, i + 1, cell.get(j) == null ? ""
								: cell.get(j).toString());
						// 将定义好的单元格添加到工作表中
						sheet.addCell(label);
					}
				}
			}
			// 加入合计
			if (list2 != null && list2.size() > 0) {
				Label label1 = new Label(0, len + 1,"合计：");
				sheet.addCell(label1);
				for (int i = 0; i < list2.size(); i++) {
					List cell = (List) list2.get(i);
					for (int j = 0; j < cell.size(); j++) {
						Label label = new Label(j+1, len + 1 + i,
								cell.get(j) == null ? "" : cell.get(j).toString());
						// 将定义好的单元格添加到工作表中
						sheet.addCell(label);
					}
				}
			}
			// 写入数据
			book.write();
			// 写入数据并关闭文件
			book.close();
			os.flush();
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}