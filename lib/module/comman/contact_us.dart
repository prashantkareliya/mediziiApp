import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/components/custom_loading_wrapper.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/module/authentication/bloc/auth_bloc.dart';
import 'package:medizii/module/authentication/bloc/auth_event.dart';
import 'package:medizii/module/authentication/bloc/auth_state.dart';
import 'package:medizii/module/authentication/data/datasource.dart';
import 'package:medizii/module/authentication/data/repository.dart';
import 'package:medizii/module/authentication/model/comman_data_response.dart';

class ContactUs extends StatelessWidget {
  ContactUs({super.key}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authBloc.add(ContactUsEvent());
    });
  }

  bool showSpinner = false;
  CommonDataResponse? commonDataResponse;
  String? htmlContent;
  AuthBloc authBloc = AuthBloc(AuthRepository(authDatasource: AuthDatasource()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Contact Us', isBack: true),
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is FailureState) {
            showSpinner = false;
            Helpers.showSnackBar(context, state.error);
          }
          if (state is LoadingState) {
            showSpinner = true;
          }
          if (state is LoadedState) {
            showSpinner = false;
            commonDataResponse = state.data;
            htmlContent = commonDataResponse?.data;
          }
        },
        builder: (context, state) {
          return LoadingWrapper(
            showSpinner: showSpinner,
            child: SingleChildScrollView(padding: EdgeInsets.all(16), child: HtmlWidget(htmlContent ?? "")),
          );
        },
      ),
    );
  }
}
