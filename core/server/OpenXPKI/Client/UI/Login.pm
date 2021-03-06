# OpenXPKI::Client::UI::Login
# Written 2013 by Oliver Welter
# (C) Copyright 2013 by The OpenXPKI Project

package OpenXPKI::Client::UI::Login;

use Moose;
use Data::Dumper;

extends 'OpenXPKI::Client::UI::Result';

my $meta = __PACKAGE__->meta;

sub BUILD {

    my $self = shift;

}

sub init_realm_select {

    my $self = shift;
    my $realms = shift;

    my @realms = sort { lc($a->{label}) cmp lc($b->{label}) } @{$realms};

    $self->_page ({'label' => 'I18N_OPENXPKI_UI_LOGIN_PLEASE_LOG_IN'});
    $self->_result()->{main} = [{ 'type' => 'form', 'action' => 'login!realm',  content => {
        fields => [
            { 'name' => 'pki_realm', 'label' => 'I18N_OPENXPKI_UI_PKI_REALM_LABEL', 'type' => 'select', 'options' => \@realms },
        ]}
    }];
    return $self;
}

sub init_auth_stack {

    my $self = shift;
    my $stacks = shift;

    my @stacks = sort { lc($a->{label}) cmp lc($b->{label}) } @{$stacks};

    $self->_page ({'label' => 'I18N_OPENXPKI_UI_LOGIN_PLEASE_LOG_IN'});
    $self->_result()->{main} = [
        { 'type' => 'form', 'action' => 'login!stack', content => {
            title => '', submit_label => 'I18N_OPENXPKI_UI_LOGIN_SUBMIT',
            fields => [
                { 'name' => 'auth_stack', 'label' => 'Handler', 'type' => 'select', 'options' => \@stacks },
            ]
        }
    }];

    return $self;
}

sub init_login_passwd {

    my $self = shift;

    $self->_page ({'label' => 'I18N_OPENXPKI_UI_LOGIN_PLEASE_LOG_IN'});
    $self->_result()->{main} = [{ 'type' => 'form', 'action' => 'login!password', content => {
        fields => [
            { 'name' => 'username', 'label' => 'I18N_OPENXPKI_UI_LOGIN_USERNAME', 'type' => 'text' },
            { 'name' => 'password', 'label' => 'I18N_OPENXPKI_UI_LOGIN_PASSWORD', 'type' => 'password' },
        ]}
    }];

    return $self;

}

sub init_login_missing_data {

    my $self = shift;
    my $args = shift;

    $self->_page ({
        'label' => 'I18N_OPENXPKI_UI_LOGIN_NO_DATA_HEAD'
    });

    $self->add_section({
        type => 'text',
        content => {
            label => '',
            description => 'I18N_OPENXPKI_UI_LOGIN_NO_DATA_PAGE'
        }
    });

    return $self;
}


sub init_logout {

    my $self = shift;
    my $args = shift;

    $self->_page ({
        'label' => 'I18N_OPENXPKI_UI_HOME_LOGOUT_HEAD'
    });

    $self->add_section({
        type => 'text',
        content => {
            label => '',
            description => 'I18N_OPENXPKI_UI_HOME_LOGOUT_PAGE'
        }
    });

    return $self;
}


sub init_index {

    my $self = shift;

    $self->redirect('redirect!welcome');

    return $self;
}

1;
