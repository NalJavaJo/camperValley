<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<table class="table text-center">
	<thead>
		<tr>
			<th scope="col">ȸ�����̵�</th>
			<th scope="col">�޼���</th>
			<th scope="col">������ �޼�����</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list}" var="chatLog">
			<tr>
				<td>${chatLog.memberId}</td>
				<td>${chatLog.msg}</td>
				<td></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</body>
</html>