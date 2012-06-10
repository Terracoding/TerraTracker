if Rails.env.production?
  GoCardless.account_details = {
    :app_id     => '_jI0R4zYCG8bNONhNNfFJBruOt5087nitPaO5E4lYyRY_OqY7En62uv_IAcXjpPJ',
    :app_secret => 'lVFUCVRH5xz5vIuw7TodIof_YYUzhWffR8V7zilaCPT78h7EAD1dVQkM_YJdkB65',
    :token      => 'Lg41ebP8WULDBM3h+PdP4SXxqF33rFrt8ZBxhZ5D9HGCRgIX4EAOG2MYOcFjt8Je manage_merchant:03RQ003RQE',
  }
else
  GoCardless.environment = :sandbox
  GoCardless.account_details = {
    :app_id     => 'W13kTIr_fojsV3B4c37CenaVooTRrp_wOrWE_QBf3f_P70D54HEqVjfCUaqE1XGu',
    :app_secret => 'NxLeboi0bNjc0mtSvb4VgmYxhyud12XvFmsOZUCLgTGcFAmeK5LjV9HVG4Msnu7k',
    :token      => 'Vf+uZWMaliAHmxFDGJC5MYyuLSWxG0o250a2zA0SPfAVznmVWT+pIoDKkLMi7AIb manage_merchant:0262XFYC2K',
  }
end

