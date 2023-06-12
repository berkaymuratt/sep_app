import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/pages/appointment_details_page/dart/appointment_details_page.dart';
import 'package:sep_app/app/pages/appointment_details_page/dart/appointment_details_page_view_model.dart';
import 'package:sep_app/app/pages/appointments_page/appointments_page.dart';
import 'package:sep_app/app/pages/appointments_page/appointments_page_view_model.dart';
import 'package:sep_app/app/pages/create_appointment_page/create_appointment_page.dart';
import 'package:sep_app/app/pages/create_appointment_page/create_appointment_page_view_model.dart';
import 'package:sep_app/app/pages/doctor_info_page/doctor_info_page.dart';
import 'package:sep_app/app/pages/doctor_info_page/doctor_info_page_view_model.dart';
import 'package:sep_app/app/pages/fqa_page/faq_page.dart';
import 'package:sep_app/app/pages/fqa_page/faq_page_view_model.dart';
import 'package:sep_app/app/pages/home_page/home_page.dart';
import 'package:sep_app/app/pages/landing_page/landing_page.dart';
import 'package:sep_app/app/pages/login_page/login_page.dart';
import 'package:sep_app/app/pages/profile_page/profile_page.dart';
import 'package:sep_app/app/pages/profile_page/profile_page_view_model.dart';
import 'package:sep_app/app/pages/report_details_page/dart/report_details_page.dart';
import 'package:sep_app/app/pages/report_details_page/dart/report_details_page_view_model.dart';
import 'package:sep_app/app/pages/reports_page/reports_page.dart';
import 'package:sep_app/app/pages/reports_page/reports_page_view_model.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LandingPage();
      },
    ),
    _loginRoute(),
    GoRoute(
        path: '/home',
        pageBuilder: (context, state) {
          return _byFadeTransition(context, state, const HomePage());
        },
        routes: [
          _doctorInfoRoutes(),
          _myAppointmentsRoutes(),
          _myReportsRoutes(),
          _createAppointmentRoutes(),
          _profileRoute(),
          _faqRoute(),
        ]),
  ],
);

GoRoute _doctorInfoRoutes() {
  return GoRoute(
    path: 'doctor-info',
    pageBuilder: (context, state) {
      return _byFadeTransition(
        context,
        state,
        ChangeNotifierProvider(
          create: (context) => DoctorInfoPageViewModel(),
          child: const DoctorInfoPage(),
        ),
      );
    },
  );
}

GoRoute _myAppointmentsRoutes() {
  return GoRoute(
      path: 'my-appointments',
      pageBuilder: (context, state) {
        return _byFadeTransition(
          context,
          state,
          ChangeNotifierProvider(
            create: (context) => AppointmentsPageViewModel(),
            child: const AppointmentsPage(),
          ),
        );
      },
      routes: [
        GoRoute(
          path: ':id',
          pageBuilder: (context, state) {
            final String? id = state.params['id'];

            if (id == null) {
              // Redirect to the page not found
            }

            return _byFadeTransition(
              context,
              state,
              ChangeNotifierProvider(
                create: (context) => AppointmentDetailsPageViewModel(),
                child: AppointmentDetailsPage(appointmentId: id!),
              ),
            );
          },
        ),
      ]
  );
}

GoRoute _myReportsRoutes() {
  return GoRoute(
      path: 'my-reports',
      pageBuilder: (context, state) {
        return _byFadeTransition(
          context,
          state,
          ChangeNotifierProvider(
            create: (context) => ReportsPageViewModel(),
            child: const ReportsPage(),
          ),
        );
      },
      routes: [
        GoRoute(
          path: ':id',
          pageBuilder: (context, state) {
            final String? id = state.params['id'];

            if (id == null) {
              // Redirect to the page not found
            }

            return _byFadeTransition(
              context,
              state,
              ChangeNotifierProvider(
                create: (context) => ReportDetailsPageViewModel(),
                child: ReportDetailsPage(reportId: id!),
              ),
            );
          },
        ),
      ]
  );
}

GoRoute _createAppointmentRoutes() {
  return GoRoute(
    path: 'create-appointment',
    pageBuilder: (context, state) {
      return _byFadeTransition(
        context,
        state,
        ChangeNotifierProvider(
          create: (context) => CreateAppointmentPageViewModel(),
          child: CreateAppointmentPage(),
        ),
      );
    },
  );
}

GoRoute _profileRoute() {
  return GoRoute(
    path: 'profile',
    pageBuilder: (context, state) {
      return _byFadeTransition(
        context,
        state,
        ChangeNotifierProvider(
          create: (context) => ProfilePageViewModel(),
          child: const ProfilePage(),
        ),
      );
    },
  );
}

GoRoute _faqRoute() {
  return GoRoute(
    path: 'faq',
    pageBuilder: (context, state) {
      return _byFadeTransition(
        context,
        state,
        ChangeNotifierProvider(
          create: (context) => FaqPageViewModel(),
          child: const FaqPage(),
        ),
      );
    },
  );
}

GoRoute _loginRoute() {
  return GoRoute(
    path: "/login",
    pageBuilder: (context, state) {
      return _byFadeTransition(context, state, LoginPage());
    },
  );
}

CustomTransitionPage _byFadeTransition(
    BuildContext context, GoRouterState state, Widget page) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
