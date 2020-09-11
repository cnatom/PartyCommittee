
import 'package:party_committee/NetClass/changepass_info.dart';
import 'package:party_committee/NetClass/chengji_info.dart';
import 'package:party_committee/NetClass/login_info.dart';
import 'package:party_committee/NetClass/news_info.dart';
import 'package:party_committee/NetClass/passPdf_info.dart';
import 'package:party_committee/NetClass/qingjiaResultTea_info.dart';
import 'package:party_committee/NetClass/qingjiaResult_info.dart';
import 'package:party_committee/NetClass/searchStu_info.dart';
import 'package:party_committee/NetClass/searchStudentParents_info.dart';
import 'package:party_committee/NetClass/searchStudent_info.dart';
import 'package:party_committee/NetClass/student_info.dart';
import 'package:party_committee/NetClass/swiper_info.dart';
import 'package:party_committee/NetClass/teacher_info.dart';

//实体类实例汇总
class Global{
  static SwiperInfo swiperInfo = new SwiperInfo();  //轮播图数据实体类
  static NewsInfo newsInfo = new NewsInfo(); //新闻数据实体类
  static LoginInfo loginInfo = new LoginInfo(); //返回的登录数据实体类
  static StudentInfo studentInfo = new StudentInfo(); //存储学生信息
  static TeacherInfo teacherInfo = new TeacherInfo(); //存储老师信息
  static StudentInfo checkToken = new StudentInfo(); //用于检测token是否过期
  static ChangePassInfo changePassInfo = new ChangePassInfo();//修改密码
  static ChengjiInfo chengjiInfo = new ChengjiInfo();//成绩查询结果
  static PassPdfInfo passPdfInfo = new PassPdfInfo();//入校申请回执信息
  static SearchStuInfo searchStuInfo = new SearchStuInfo();//学生查询结果列表
  static SearchStudentInfo searchStudentInfo = new SearchStudentInfo();//查询学生的详细信息
//  static SearchStudentParentsInfo searchStudentParentsInfo = new SearchStudentParentsInfo();//查询学生父母的详细信息
  static QingjiaResultInfo qingjiaResultInfo = new QingjiaResultInfo();//查看请假记录
  static List<QingjiaResultTeaInfo> qingjiaresultTeaInfoList = [
    new QingjiaResultTeaInfo(),//请假待审核
    new QingjiaResultTeaInfo(),//请假已批准
    new QingjiaResultTeaInfo(),//请假已拒绝
  ];

  static int admin;//判断当前用户权限 0学生 1老师 2领导
  static String name;
  static String id;
  static String curVersion;
  static bool igUpgrade;
  static String token;
}